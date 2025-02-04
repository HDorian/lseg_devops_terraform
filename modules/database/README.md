<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

The following Modules are called:

### <a name="module_dynamodb"></a> [dynamodb](#module\_dynamodb)

Source: terraform-aws-modules/dynamodb-table/aws

Version: 4.2.0

## Resources

No resources.

## Required Inputs

The following input variables are required:

### <a name="input_dynamodb_config"></a> [dynamodb\_config](#input\_dynamodb\_config)

Description: DynamoDB table configuration

Type:

```hcl
object({
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
    kms_key_arn = optional(string)
  })
```

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn)

Description: DynamoDB table ARN

### <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name)

Description: DynamoDB table name
<!-- END_TF_DOCS -->