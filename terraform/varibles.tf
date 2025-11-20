variable "aws_region" { default = "us-east-1" }
variable "instance_type" { default = "t3.micro" }
variable "key_name" { default = "k3s_key" }
variable "public_key_path" { default = "~/.ssh/id_rsa.pub" }