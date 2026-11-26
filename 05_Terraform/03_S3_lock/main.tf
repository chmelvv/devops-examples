terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.74.0"
    }
  }
}

# Configure the AWS Provider matching ~/.aws/config
provider "aws" {
  region                      = "eu-west-2"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    ec2 = "http://localhost:4566"
    s3  = "http://localhost:4566"
    sts = "http://localhost:4566"
  }
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