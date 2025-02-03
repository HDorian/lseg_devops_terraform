variable "network_config" {
  description = "Network configuration including VPC, subnets, and routing"
  type = object({
    vpc_cidr = string
    vpc_name = string
    public_subnets = list(object({
      cidr = string
      az   = string
    }))
    private_subnets = list(object({
      cidr = string
      az   = string
    }))
  })
}
