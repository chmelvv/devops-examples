# Globally unique S3 bucket name for storing Terraform state files
variable "bucket_name" {
  description = "Unique name of the S3 bucket for Terraform state"
  type        = string
}

# Environment or project tag
variable "project_name" {
  description = "Project name used for resource tagging"
  type        = string
  default     = "devops-iac-lab"
}