data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  # Attach the Security Group created above
  vpc_security_group_ids = [aws_security_group.ec2_monitor_sg.id]

  # Uncomment and specify your AWS SSH key name for access
  # key_name = "my-aws-key"

  tags = {
    Name        = "Prometheus-Target-EC2"
    Environment = "Demo"
    ManagedBy   = "Terraform"
  }
}