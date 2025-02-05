<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.0)

- <a name="requirement_aws"></a> [aws](#requirement\_aws) (~> 5.72.1)

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (5.84.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [aws_autoscaling_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) (resource)
- [aws_iam_role.replication_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) (resource)
- [aws_launch_template.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) (resource)
- [aws_lb.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) (resource)
- [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) (resource)
- [aws_lb_target_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) (resource)
- [aws_s3_bucket.lb_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) (resource)
- [aws_s3_bucket_lifecycle_configuration.lb_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) (resource)
- [aws_s3_bucket_logging.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) (resource)
- [aws_s3_bucket_notification.bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) (resource)
- [aws_s3_bucket_public_access_block.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) (resource)
- [aws_s3_bucket_replication_configuration.lb_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) (resource)
- [aws_s3_bucket_server_side_encryption_configuration.good_sse_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) (resource)
- [aws_s3_bucket_versioning.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) (resource)
- [aws_sns_topic.bucket_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) (resource)
- [aws_wafregional_ipset.foo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafregional_ipset) (resource)
- [aws_wafregional_rule.foo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafregional_rule) (resource)
- [aws_wafregional_web_acl.foo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafregional_web_acl) (resource)
- [aws_wafregional_web_acl_association.foo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafregional_web_acl_association) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_allow_https_sg_id"></a> [allow\_https\_sg\_id](#input\_allow\_https\_sg\_id)

Description: n/a

Type: `string`

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