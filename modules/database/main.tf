terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.1"
    }
  }
}

module "dynamodb" {
  # checkov:skip=CKV_TF_1 This module uses Terraform Registry, commit hash not possible
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "4.2.0"

  name                           = var.dynamodb_config.name
  billing_mode                   = var.dynamodb_config.billing_mode
  hash_key                       = var.dynamodb_config.hash_key
  range_key                      = var.dynamodb_config.range_key
  attributes                     = var.dynamodb_config.attributes
  read_capacity                  = var.dynamodb_config.read_capacity
  write_capacity                 = var.dynamodb_config.write_capacity
  global_secondary_indexes       = var.dynamodb_config.global_secondary_indexes
  point_in_time_recovery_enabled = true
  autoscaling_enabled            = true

  # Enable server-side encryption with the default AWS key
  server_side_encryption_enabled = true

  # Uncomment if you have a custom key ARN (replace with actual ARN or variable)
  # server_side_encryption_kms_key_arn = var.kms_key_arn
}