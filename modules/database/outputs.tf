output "dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = module.dynamodb.dynamodb_table_name
}

output "dynamodb_table_arn" {
  description = "DynamoDB table ARN"
  value       = module.dynamodb.dynamodb_table_arn
}
