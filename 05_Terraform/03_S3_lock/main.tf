terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider matching ~/.aws/config
provider "aws" {
  region  = "eu-north-1"
  profile = "default"
}

# Bootstrap S3 bucket for remote state and native .tflock locking
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "tf-state-chmelvv-2026" # Replace with a globally unique name
}

# 2. Deploy Development web server (uncomment in Stage 2 after backend migration)
# module "dev_server" {
#   source        = "./modules/web-server"
#   instance_type = "t3.micro"
#   env_name      = "Dev"
#   web_content   = "<h1>DEVELOPMENT Server</h1><p>State is safely stored in S3!</p>"
# }

# 3. Deploy Staging web server (uncomment in Stage 2 after backend migration)
# module "stage_server" {
#   source        = "./modules/web-server"
#   instance_type = "t3.micro"
#   env_name      = "Stage"
#   web_content   = "<h1>STAGING Server</h1>"
# d}