terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-snickarboden"
    key            = "state-syst"
    dynamodb_table = "terraform"
    region         = "eu-west-1"
  }
}
provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "testing" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-vpc"
  }
}

resource "aws_subnet" "testing" {
  vpc_id     = aws_vpc.testing.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "testing-subnet"
  }
}

resource "aws_subnet" "lol" {
  vpc_id     = aws_vpc.testing.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "testing-subnet-s"
  }
}

resource "aws_instance" "test" {
  ami           = "ami-0ee415e1b8b71305f"
  instance_type = "t3.small"
  subnet_id     = aws_subnet.lol.id
  tags = {
    Name = "testing"
  }
}