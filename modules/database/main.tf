module "dynamodb" {
  source  = "terraform-aws-modules/dynamodb-table/aws?ref=e47cf5f0d2636bd5018b4a65e988295d5360cbb6"
  version = "4.2.0"

  name                     = var.dynamodb_config.name
  billing_mode             = var.dynamodb_config.billing_mode
  hash_key                 = var.dynamodb_config.hash_key
  range_key                = var.dynamodb_config.range_key
  attributes               = var.dynamodb_config.attributes
  read_capacity            = var.dynamodb_config.read_capacity
  write_capacity           = var.dynamodb_config.write_capacity
  global_secondary_indexes = var.dynamodb_config.global_secondary_indexes

  # Enable server-side encryption with the default AWS key
  server_side_encryption_enabled = true

  # Uncomment if you have a custom key ARN (replace with actual ARN or variable)
  # server_side_encryption_kms_key_arn = var.kms_key_arn
}
