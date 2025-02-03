variable "compute_config" {
  description = "Compute layer configuration including ASG, ALB, and instances"
  type = object({
    instance_type = string
    ami_id        = string
    asg_min_size  = number
    asg_max_size  = number
    asg_desired   = number
    subnets       = list(string)
  })
}
