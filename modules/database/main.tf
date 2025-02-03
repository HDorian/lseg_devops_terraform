module "dynamodb" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.1.0"

  name                     = var.dynamodb_config.name
  billing_mode             = var.dynamodb_config.billing_mode
  hash_key                 = var.dynamodb_config.hash_key
  range_key                = var.dynamodb_config.range_key
  attributes               = var.dynamodb_config.attributes
  read_capacity            = var.dynamodb_config.read_capacity
  write_capacity           = var.dynamodb_config.write_capacity
  global_secondary_indexes = var.dynamodb_config.global_secondary_indexes
}
