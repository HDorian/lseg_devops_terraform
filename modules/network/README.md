<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (5.84.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) (resource)
- [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) (resource)
- [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_network_config"></a> [network\_config](#input\_network\_config)

Description: Network configuration including VPC, subnets, and routing

Type:

```hcl
object({
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
```

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids)

Description: IDs of the private subnets

### <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids)

Description: IDs of the public subnets

### <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id)

Description: ID of the VPC
<!-- END_TF_DOCS -->