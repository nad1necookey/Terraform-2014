terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

#the resource name explains what it is so you dont need a logical id
variable "vpc_cider_block"  {}
# create variable for subnet
variable "sudnet_cidr_block" {}
#create variable for availability zone
variable "avail_zone" {}
# variable for environment. you have multiple environments (such as development, staging, and production) and you want to parameterize your Terraform configurations to work seamlessly across these environments. By using an environment prefix in variables, you can create more modular and reusable Terraform code that adapts to different environments without hardcoding specific values.
variable "env_prefix" {}

# the cider number was removed and replaced with the var.vpc_cider_block
resource "aws_vpc" "myapp_vpc" {
  cidr_block = var.vpc_cider_block
  tags = {
    Name = "${var.env_prefix}-vpc" #variable inside of a string. u would need the $ and {}
  }
}

resource "aws_subnet" "mmyapp_subnet_1" {
  vpc_id     = aws_vpc.myapp_vpc.id
  cidr_block = var.sudnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}