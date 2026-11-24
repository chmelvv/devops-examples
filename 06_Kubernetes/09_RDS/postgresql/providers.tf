provider "aws" {
  region = "eu-north-1" 
}

data "aws_vpc" "default" {
  default = true
}