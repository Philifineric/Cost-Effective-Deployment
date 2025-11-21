
# Configure the AWS provider with the desired region
provider "aws" {
	region = var.aws_region
}



# Specify the required Terraform version
terraform {
	required_version = ">= 1.0"
}