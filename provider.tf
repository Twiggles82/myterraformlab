terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
    local = {
      version = "~> 2.1"
    }
    }
  }

# Configure the AWS Provider
provider "aws" {
  region = "${var.aws_region}"
}