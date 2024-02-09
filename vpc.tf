resource "aws_vpc" "vpc-prod" {
    cidr_block = "10.180.24.0/22"  
    enable_dns_hostnames = true
    enable_dns_support = true
    
    tags = {
        Name = "vpc-prod"
    }
}

resource "aws_subnet" "sub-prod-azA-priv" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    cidr_block = "10.180.25.0/25"
    availability_zone = "eu-west-1a"
    tags = {
        Name = "sub-prod-azA-priv"
    }
}

resource "aws_subnet" "sub-prod-azA-pub" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    cidr_block = "10.180.25.128/25"
    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = "true"
    tags = {
        Name = "sub-prod-azA-pub"
    }
}

resource "aws_subnet" "sub-prod-azB-priv" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    cidr_block = "10.180.26.0/25"
    availability_zone = "eu-west-1b"
    tags = {
        Name = "sub-prod-azB-priv"
    }
}

resource "aws_subnet" "sub-prod-azB-pub" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    cidr_block = "10.180.26.128/25"
    availability_zone = "eu-west-1b"
    map_public_ip_on_launch = "true"
    tags = {
        Name = "sub-prod-azB-pub"
    }
}