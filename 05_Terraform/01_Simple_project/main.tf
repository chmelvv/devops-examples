terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.74.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.aws_region
  profile = "default"
}

# Fetch the default VPC in the selected region
data "aws_vpc" "default" {
  default = true
}

# Find the latest official Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create a Security Group to allow inbound HTTP traffic
resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  # Allow HTTP on port 80 from anywhere
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

# Create an EC2 instance and bootstrap Nginx using user_data
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Bootstrap script to install and start Nginx
  user_data = <<-EOF
              #!/bin/bash
              # Update package index and install Nginx
              apt-get update -y
              apt-get install -y nginx

              # Start and enable Nginx service
              systemctl start nginx
              systemctl enable nginx

              # Create a custom index page
              echo "<h1>Deployed via Terraform!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.project_name}-server"
  }
}