# Generate a new RSA private key for SSH access
resource "tls_private_key" "k3s_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

# Create an AWS key pair using the generated public key
resource "aws_key_pair" "k3s" {
    key_name = var.key_name
    public_key = file(var.public_key_path)
}



# Security group for k3s node: allows SSH, HTTP, and HTTPS
resource "aws_security_group" "k3s_sg" {
    name = "k3s-sg"
    description = "Allow SSH, HTTP, HTTPS"
    vpc_id = aws_vpc.main.id

    # Allow SSH from anywhere
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow HTTP from anywhere
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow HTTPS from anywhere
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow all outbound traffic
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# EC2 instance for the k3s single-node cluster
resource "aws_instance" "k3s_node" {
    ami                         = data.aws_ami.ubuntu.id
    instance_type               = var.instance_type
    subnet_id                   = aws_subnet.public.id
    vpc_security_group_ids      = [aws_security_group.k3s_sg.id]
    key_name                    = aws_key_pair.k3s.key_name
    associate_public_ip_address = true

    # Run the k3s install script on instance launch
    user_data = file("../k3s/install_k3s.sh")

    tags = {
        Name = "k3s-single-node"
    }
}


# Get the latest Ubuntu 20.04 LTS AMI from Canonical
data "aws_ami" "ubuntu" {
    most_recent = true
    owners      = ["099720109477"] # Canonical

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}


# Output the public IP of the k3s EC2 instance
output "ec2_public_ip" {
    value = aws_instance.k3s_node.public_ip
}

