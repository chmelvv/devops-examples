# Security group for the Bastion Host (EC2)
resource "aws_security_group" "bastion_sg" {
  name        = "education_bastion_sg2"
  description = "Allow SSH access to Bastion Host"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for Redis
resource "aws_security_group" "redis_sg" {
  name        = "education_redis_sg2"
  description = "Allow inbound Redis traffic from VPC"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Redis access from within the VPC"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    # Only allow connections from resources inside the same VPC
    cidr_blocks = [data.aws_vpc.default.cidr_block] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}