resource "aws_vpc" "vpc-prod" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    }

resource "aws_subnet" "private-subnet-euw1a" {
  vpc_id     = "${aws_vpc.vpc-prod.id}"
  cidr_block = "${var.private_subnet_euw1a}"
  availability_zone = "eu-west-1a"

  tags = {
     Name = "${var.tf_project_code}-1"
     Zone = "${var.tf_project_code}-2"
  }
}

resource "aws_subnet" "private_subnet_euw1b" {
  vpc_id     = "${aws_vpc.vpc-prod.id}"
  cidr_block = "${var.private_subnet_euw1b}"
  availability_zone = "eu-west-1a"

  tags = {
     Name = "${var.tf_project_code}-1"
     Zone = "${var.tf_project_code}-2"
  }
}

resource "aws_subnet" "public_subnet_euw1a" {
  vpc_id     = "${aws_vpc.vpc-prod.id}"
  cidr_block = "${var.public_subnet_euw1a}"
  availability_zone = "eu-west-1a"

  tags = {
     Name = "${var.tf_project_code}-1"
     Zone = "${var.tf_project_code}-2"
  }
}

resource "aws_subnet" "public_subnet_euw1b" {
  vpc_id     = "${aws_vpc.vpc-prod.id}"
  cidr_block = "${var.public_subnet_euw1b}"
  availability_zone = "eu-west-1a"

  tags = {
     Name = "${var.tf_project_code}-1"
     Zone = "${var.tf_project_code}-2"
  }
}
# resource "aws_subnet" "sub-prod-azA-priv" {
#     vpc_id = "${aws_vpc.vpc-prod.id}"
#     cidr_block = "10.180.25.0/25"
#     availability_zone = "eu-west-1a"
#     tags = {
#         Name = "sub-prod-azA-priv"
#     }
# }

# resource "aws_subnet" "sub-prod-azA-pub" {
#     vpc_id = "${aws_vpc.vpc-prod.id}"
#     cidr_block = "10.180.25.128/25"
#     availability_zone = "eu-west-1a"
#     map_public_ip_on_launch = "true"
#     tags = {
#         Name = "sub-prod-azA-pub"
#     }
# }

# resource "aws_subnet" "sub-prod-azB-priv" {
#     vpc_id = "${aws_vpc.vpc-prod.id}"
#     cidr_block = "10.180.26.0/25"
#     availability_zone = "eu-west-1b"
#     tags = {
#         Name = "sub-prod-azB-priv"
#     }
# }

# resource "aws_subnet" "sub-prod-azB-pub" {
#     vpc_id = "${aws_vpc.vpc-prod.id}"
#     cidr_block = "10.180.26.128/25"
#     availability_zone = "eu-west-1b"
#     map_public_ip_on_launch = "true"
#     tags = {
#         Name = "sub-prod-azB-pub"
#     }
# }