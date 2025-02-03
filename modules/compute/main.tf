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
  desired_capacity    = var.compute_config.asg_desired
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
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [] # Add security group here
  subnets            = var.compute_config.subnets
}

resource "aws_lb_target_group" "app" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_autoscaling_group.app.vpc_zone_identifier[0]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
