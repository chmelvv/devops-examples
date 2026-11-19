resource "aws_security_group" "rds_sg" {
  name        = "education_rds_sg"
  description = "Allow inbound traffic for RDS PostgreSQL"
  vpc_id      = data.aws_vpc.default.id

  # Inbound traffic: allow connections to the PostgreSQL port
  ingress {
    description = "PostgreSQL access from anywhere (For Demo Only!)"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allowed from anywhere to simplify the lab
  }

  # Outbound traffic: allow the database to initiate any outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}