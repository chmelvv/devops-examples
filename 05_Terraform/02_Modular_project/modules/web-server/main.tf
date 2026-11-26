# Fetch the default VPC in the active AWS region
data "aws_vpc" "default" {
  default = true
}

# Find the latest official Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu" {
most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Environment-specific Security Group allowing HTTP access
resource "aws_security_group" "web_sg" {
  name        = "${lower(var.env_name)}-web-sg"
  description = "Allow HTTP inbound traffic for ${var.env_name}"
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
    Name        = "${var.env_name}-web-sg"
    Environment = var.env_name
  }
}

# EC2 instance configured with Nginx via user_data
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Install Nginx and deploy the environment-specific HTML page
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx

              cat << 'HTML' > /var/www/html/index.html
              ${var.web_content}
              HTML
              EOF

  tags = {
    Name        = "${var.env_name}-web-server"
    Environment = var.env_name
  }
}