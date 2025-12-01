#to run  
#terraform init
#terraform apply -var-file=backend-resources.config


# S3 bucket for Terraform state
resource "aws_s3_bucket" "tf_state" {
  bucket = var.backend_bucket_name # Change to a globally unique name
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "tf_lock" {
  name         = var.backend_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}