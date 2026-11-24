terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-north-1"
  profile = "default"
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