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
  region = "eu-west-1"
}

module "vpc" {
  source     = "./modules/vpc"

  vpc_name = var.vpc_name
  public_subnet_euw1a = var.public_subnet_euw1a
  public_subnet_euw1b = var.public_subnet_euw1b
  private_subnet_euw1a = var.private_subnet_euw1a
  private_subnet_euw1b = var.private_subnet_euw1b

  tf_project_code       = var.tf_project_code

  vpc_cidr = var.vpc_cidr
  public_subnet_cidr_euw1a = cidrsubnet(var.vpc_cidr, 8, 10)
  public_subnet_cidr_euw1b = cidrsubnet(var.vpc_cidr, 8, 11)
  private_subnet_cidr_euw1a = cidrsubnet(var.vpc_cidr, 8, 14)
  private_subnet_cidr_euw1b = cidrsubnet(var.vpc_cidr, 8, 16)

}

# module "ec2" {
#   source     = "./modules/ec2"

# }