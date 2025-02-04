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

- [aws_autoscaling_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) (resource)
- [aws_launch_template.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) (resource)
- [aws_lb.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) (resource)
- [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) (resource)
- [aws_lb_target_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_compute_config"></a> [compute\_config](#input\_compute\_config)

Description: Configuration for compute resources

Type:

```hcl
object({
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
```

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name)

Description: Load Balancer DNS

### <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name)

Description: Auto Scaling Group name
<!-- END_TF_DOCS -->