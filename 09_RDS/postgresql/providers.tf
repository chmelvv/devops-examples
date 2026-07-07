provider "aws" {
  region = "eu-west-2" 
}

data "aws_vpc" "default" {
  default = true
}