data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Upload the Public Key to AWS EC2
resource "aws_key_pair" "bastion_key_pair" {
  key_name   = "student-bastion-key"
  public_key = tls_private_key.bastion_key.public_key_openssh
}

# 3. Save the Private Key locally as a .pem file
resource "local_file" "private_key_pem" {
  content         = tls_private_key.bastion_key.private_key_pem
  filename        = "${path.module}/student-bastion-key.pem"
  file_permission = "0400" # Important: SSH requires strict file permissions
}

# The Bastion Host instance
resource "aws_instance" "bastion2" {
  ami             = data.aws_ami.amazon_linux.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.bastion_sg.name]
  
  # Attach the dynamically generated key pair here:
  key_name = aws_key_pair.bastion_key_pair.key_name 

  associate_public_ip_address = true

  tags = {
    Name = "Redis-Bastion-Host"
  }
}

