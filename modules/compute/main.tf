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
  name               = var.compute_config.lb_name
  internal           = var.compute_config.lb_internal
  load_balancer_type = var.compute_config.lb_type
  security_groups    = var.compute_config.security_groups
  subnets            = var.compute_config.subnets
}

resource "aws_lb_target_group" "app" {
  name     = var.compute_config.tg_name
  port     = var.compute_config.tg_port
  protocol = var.compute_config.tg_protocol
  vpc_id   = var.compute_config.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = var.compute_config.listener_port
  protocol          = var.compute_config.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
