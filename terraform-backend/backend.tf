# to run  === terraform init -backend-config=backend.config
terraform {
  required_version = ">= 1.0"
  backend "s3" {
    bucket         = ""   # Same as above
    key            = ""        # Path within the bucket
    region         = ""
    dynamodb_table = ""                    # Same as above
    encrypt        = true
  }
}
