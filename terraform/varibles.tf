
# AWS region to deploy resources in
variable "aws_region" {
	default = "us-east-1"
}

# EC2 instance type for the k3s node
variable "instance_type" {
	default = "t3.micro"
}

# Name for the AWS key pair
variable "key_name" {
	description = "name for the AWS key pair"
  	type        = string
}

# Path to the public SSH key used for EC2 access
variable "public_key_path" {
	description = "Path to the public SSH key used for EC2 access"
  	type        = string
}