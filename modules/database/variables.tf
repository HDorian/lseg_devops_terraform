variable "dynamodb_config" {
  description = "DynamoDB table configuration"
  type = object({
    name           = string
    billing_mode   = string
    hash_key       = string
    range_key      = optional(string)
    attributes     = list(map(string))
    read_capacity  = optional(number)
    write_capacity = optional(number)
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
}

/* variable "kms_key_arn" {
  description = "The ARN of the KMS key for encryption"
  type        = string
}
 */
