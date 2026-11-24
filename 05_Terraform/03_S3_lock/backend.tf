# Configure remote state storage in S3
# Note: Terraform backend blocks do not support variables; values must be static strings
# terraform {
#   backend "s3" {
#     bucket         = "tf-state-chmelvv-2026" # Must match bucket_name in main.tf
#     key            = "project-3/terraform.tfstate"
#     region         = "eu-north-1"
#     encrypt        = true
#     use_lockfile = true # Creates a .tflock file directly inside the S3 bucket
#   }
# }