output "asg_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.app.name
}

output "alb_dns_name" {
  description = "Load Balancer DNS"
  value       = aws_lb.app.dns_name
}
