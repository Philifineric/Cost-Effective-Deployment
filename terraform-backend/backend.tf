
terraform {
  required_version = ">= 1.0"
  backend "s3" {
    bucket         = "your-unique-tf-state-bucket-name"   # Same as above
    key            = "global/s3/terraform.tfstate"        # Path within the bucket
    region         = var.aws_region
    dynamodb_table = "terraform-locks"                    # Same as above
    encrypt        = true
  }
}