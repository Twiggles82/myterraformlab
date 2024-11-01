resource "aws_vpc" "vpc-prod" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public-subnet-euw1a" {
  vpc_id            = aws_vpc.vpc-prod.id
  cidr_block        = var.public_subnet_cidr_euw1a
  availability_zone = "eu-west-1a"

  tags = {
    Name = "${var.tf_project_code}-public-euw1a"
  }
}

resource "aws_subnet" "public-subnet-euw1b" {
  vpc_id            = aws_vpc.vpc-prod.id
  cidr_block        = var.public_subnet_cidr_euw1b
  availability_zone = "eu-west-1b"

  tags = {
    Name = "${var.tf_project_code}-public-euw1b"
  }
}

resource "aws_subnet" "private-subnet-euw1a" {
  vpc_id            = aws_vpc.vpc-prod.id
  cidr_block        = var.private_subnet_cidr_euw1a
  availability_zone = "eu-west-1a"

  tags = {
    Name = "${var.tf_project_code}-private-euw1a"
  }
}

resource "aws_subnet" "private-subnet-euw1b" {
  vpc_id            = aws_vpc.vpc-prod.id
  cidr_block        = var.private_subnet_cidr_euw1b
  availability_zone = "eu-west-1b"

  tags = {
    Name = "${var.tf_project_code}-private-euw1b"
  }
}
