# Output the S3 bucket name for the Terraform state backend
output "backend_bucket_name" {
  value       = aws_s3_bucket.tf_state.bucket
  description = "Name of the S3 bucket for Terraform state backend"
}

# Output the DynamoDB table name for state locking
output "backend_table_name" {
  value       = aws_dynamodb_table.tf_lock.name
  description = "Name of the DynamoDB table for state locking"
}

# Output the S3 bucket ARN (useful for IAM policies)
output "backend_bucket_arn" {
  value       = aws_s3_bucket.tf_state.arn
  description = "ARN of the S3 bucket for Terraform state backend"
}

# Output the DynamoDB table ARN (useful for IAM policies)
output "backend_table_arn" {
  value       = aws_dynamodb_table.tf_lock.arn
  description = "ARN of the DynamoDB table for state locking"
}