terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.74.0"
    }
  }
}

# Configure the AWS Provider
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

# Deploy the Development web server using the local module
module "dev_server" {
  source        = "./modules/web-server"
  instance_type = "t3.micro"
  env_name      = "Dev"
  web_content   = "<h1>Welcome to the DEVELOPMENT Server</h1><p>Code changes land here first.</p>"
}

# Deploy the Staging web server using the same local module
module "stage_server" {
  source        = "./modules/web-server"
  instance_type = "t3.micro"
  env_name      = "Stage"
  web_content   = "<h1>Welcome to the STAGING Server</h1><p>Pre-production testing environment.</p>"
}