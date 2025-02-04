output "dynamodb_table_name" {
  value = module.dynamodb.this_dynamodb_table_name
}

output "dynamodb_table_arn" {
  description = "DynamoDB table ARN"
  value       = module.dynamodb.dynamodb_table_arn
}

