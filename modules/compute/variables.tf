variable "compute_config" {
  description = "Configuration for compute resources"
  type = object({
    ami_id            = string
    instance_type     = string
    asg_min_size      = number
    asg_max_size      = number
    asg_desired_size  = number
    security_groups   = list(string)
    subnets           = list(string)
    tg_name           = string
    tg_port           = number
    tg_protocol       = string
    vpc_id            = string
    listener_port     = number
    listener_protocol = string
    lb_name           = string
    lb_internal       = bool
    lb_type           = string
  })
}

variable "allow_https_sg_id" {
  type = string
}
