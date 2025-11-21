resource "tls_private_key" "k3s_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "k3s" {
    key_name = var.key_name
    public_key = file(var.public_key_path)
}


resource "aws_security_group" "k3s_sg" {
    name = "k3s-sg"
    description = "Allow SSH, HTTP, HTTPS"
    vpc_id = aws_vpc.main.id


ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}


egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "k3s_node" {
ami = data.aws_ami.ubuntu.id
instance_type = var.instance_type
subnet_id = aws_subnet.public.id
vpc_security_group_ids = [aws_security_group.k3s_sg.id]
key_name = aws_key_pair.k3s.key_name
associate_public_ip_address = true


user_data = file("../k3s/install_k3s.sh")


tags = { Name = "k3s-single-node" }
}


data "aws_ami" "ubuntu" {
most_recent = true
owners = ["099720109477"] # Canonical
filter {
name = "name"
values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
}
}


output "ec2_public_ip" {
value = aws_instance.k3s_node.public_ip
}

