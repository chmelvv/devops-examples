resource "aws_security_group" "ec2_monitor_sg" {
  name        = "ec2-prometheus-monitor-sg"
  description = "Allow Prometheus to scrape metrics and SSH access"
  
  # Uncomment and specify vpc_id if you are not using the Default VPC
  # vpc_id      = var.vpc_id 

  # Allow Prometheus (port 9100) only from the EKS network
  ingress {
    description = "Allow Prometheus scraping from EKS"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = [var.eks_vpc_cidr] 
  }

  # Allow SSH (port 22)
  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For production, replace with your static IP
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}