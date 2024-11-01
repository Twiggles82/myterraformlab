terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source          = "./modules/vpc"
  
  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  tf_project_code = var.tf_project_code
  
  public_subnet_cidr_euw1a  = cidrsubnet(var.vpc_cidr, 8, 8)
  public_subnet_cidr_euw1b  = cidrsubnet(var.vpc_cidr, 8, 9)
  private_subnet_cidr_euw1a  = cidrsubnet(var.vpc_cidr, 8, 10)
  private_subnet_cidr_euw1b  = cidrsubnet(var.vpc_cidr, 8, 11)
}

module "ec2" {
  source = "./modules/ec2"

  tf_project_code = var.tf_project_code
  desktop_root_ebs_type = var.desktop_root_ebs_type
  desktop_root_ebs_size = var.desktop_root_ebs_size
  desktop_ami = var.desktop_ami
  subnet_id = module.vpc.public_subnet_id_euw1a
}