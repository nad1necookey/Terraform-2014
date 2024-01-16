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

resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "Terraform-VPC1"
  }
}
resource "aws_subnet" "sub1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Terraform-sub-1"
  }
}

data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_subnet" "sub2" {
  vpc_id            = data.aws_vpc.default_vpc.id
  cidr_block        = "172.31.96.0/20"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Terraform-sub-2"
  }
}