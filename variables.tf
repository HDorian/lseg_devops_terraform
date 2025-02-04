variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
}

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
    tg_name             = string
    tg_port             = number
    tg_protocol         = string
    vpc_id              = string
    listener_port       = number
    listener_protocol   = string
    lb_name             = string
    lb_internal         = bool
    lb_type             = string
  })
}


variable "network_config" {
  description = "Configuration for network resources"
  type = object({
    vpc_cidr        = string
    vpc_name        = string
    public_subnets  = list(map(string))
    private_subnets = list(map(string))
  })
}

variable "dynamodb_config" {
  description = "DynamoDB table configuration"
  type = object({
    name                     = string
    billing_mode             = string
    hash_key                 = string
    range_key                = optional(string)
    attributes               = list(map(string))
    read_capacity            = optional(number)
    write_capacity           = optional(number)
    global_secondary_indexes = optional(list(object({
      name            = string
      hash_key        = string
      range_key       = optional(string)
      projection_type = string
      read_capacity   = optional(number)
      write_capacity  = optional(number)
    })), [])
    kms_master_key_id        = optional(string)
  })
}
