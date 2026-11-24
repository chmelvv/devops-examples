variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Size of the instance"
}

variable "aws_region" {
    type = string
    default = "eu-north-1"
}

variable "project_name" {
  description = "Simple terraform project"
  type        = string
  default     = "terraform-web-demo"
}