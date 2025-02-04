variable "compute_config" {
  description = "Configuration for compute resources"
  type = object({
    ami_id          = string
    instance_type   = string
    security_groups = list(string)
    subnets         = list(string)
    asg_max_size    = number
    asg_min_size    = number
    asg_desired     = number
  })
}
