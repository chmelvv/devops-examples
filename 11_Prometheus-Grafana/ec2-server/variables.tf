variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-central-1" # Change to your region, e.g., us-east-1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro" 
}

variable "eks_vpc_cidr" {
  description = "CIDR block of your EKS cluster (for Prometheus access)"
  type        = string
  default     = "10.0.0.0/16" # Make sure to replace this with the actual CIDR of your EKS VPC
}