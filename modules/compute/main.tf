terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.1"
    }
  }
}

resource "aws_s3_bucket" "lb_logs" {
  bucket = "placeholder-lb-logs-bucket"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.lb_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "good_sse_1" {
  bucket = aws_s3_bucket.lb_logs.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = "example-key"
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lb_logs" {
  bucket = aws_s3_bucket.lb_logs.id

  rule {
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
    filter {}
    id     = "log"
    status = "Enabled"
  }


  rule {
    id     = "expire"
    status = "Enabled"

    filter {
      prefix = "logs/"
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 90
    }
  }
}

resource "aws_wafregional_web_acl_association" "foo" {
  resource_arn = aws_lb.app.arn
  web_acl_id   = aws_wafregional_web_acl.foo.id
}

resource "aws_s3_bucket_replication_configuration" "lb_logs" {
  bucket = aws_s3_bucket.lb_logs.id
  role   = aws_iam_role.replication_role.arn

  rule {
    id     = "replication_rule"
    status = "Enabled"

    filter {
      prefix = ""
    }

    destination {
      bucket        = aws_s3_bucket.lb_logs_destination.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_policy" {
  bucket = aws_s3_bucket.lb_logs.arn

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.lb_logs.arn

  target_bucket = aws_s3_bucket.lb_logs.arn
  target_prefix = "log/"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.lb_logs.arn

  topic {
    topic_arn     = aws_sns_topic.bucket_notifications.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "logs/"
  }
}

resource "aws_sns_topic" "bucket_notifications" {
  name              = "bucket-notifications"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_launch_template" "app" {
  name_prefix   = "app-launch-template"
  image_id      = var.compute_config.ami_id
  instance_type = var.compute_config.instance_type

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-instance"
    }
  }

  metadata_options {
    http_endpoint               = "disabled"
    http_tokens                 = "required" # This enforces the use of IMDSv2 / Chevkov: CKV_AWS_79 FIX
    http_put_response_hop_limit = 1          # Optional: adjust hop limit as needed
  }
}

resource "aws_autoscaling_group" "app" {
  desired_capacity    = var.compute_config.asg_desired_size
  max_size            = var.compute_config.asg_max_size
  min_size            = var.compute_config.asg_min_size
  vpc_zone_identifier = var.compute_config.subnets

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}

resource "aws_lb" "app" {
  name                       = var.compute_config.lb_name
  internal                   = var.compute_config.lb_internal
  load_balancer_type         = var.compute_config.lb_type
  security_groups            = module.network.allow_https_sg_id
  subnets                    = var.compute_config.subnets
  enable_deletion_protection = true
  drop_invalid_header_fields = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.arn
    prefix  = "test-lb"
    enabled = true
  }

}

resource "aws_lb_target_group" "app" {
  name     = var.compute_config.tg_name
  port     = var.compute_config.tg_port
  protocol = var.compute_config.tg_protocol
  vpc_id   = var.compute_config.vpc_id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = "/"     # Using "/" as a placeholder path
    protocol            = "HTTPS" # Ensures the health check uses HTTPS
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = var.compute_config.listener_port
  protocol          = var.compute_config.listener_protocol
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06" # Enforces TLS 1.2 and above
  # certificate_arn   = var.compute_config.listener_certificate_arn  # Provide your certificate ARN


  default_action {
    type             = "redirect"
    target_group_arn = aws_lb_target_group.app.arn
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
