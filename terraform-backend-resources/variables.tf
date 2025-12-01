variable "backend_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
}

variable "backend_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
}