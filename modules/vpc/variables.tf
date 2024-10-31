variable "tf_project_code" {
  description = "Project Code"
  type        = string
}

variable "vpc_name" {
   description = "The name of the VPC"
   type = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
}

variable "private_subnet_euw1a" {
  description = "Private Subnet for eu-west-1a"
  type        = string
}

variable "private_subnet_euw1b" {
  description = "Private Subnet for eu-west-1b"
  type        = string
}

variable "public_subnet_euw1a" {
  description = "Public Subnet for eu-west-1a"
  type        = string
}

variable "public_subnet_euw1b" {
  description = "Public Subnet for eu-west-1b"
  type        = string
}

variable "public_subnet_cidr_euw1a" {
   description = "CIDR Range for public subnet - EU West 1a"
   type = string
}

variable "public_subnet_cidr_euw1b" {
   description = "CIDR Range for public subnet - EU West 1b"
   type = string
}

variable "private_subnet_cidr_euw1a" {
   description = "CIDR Range for private subnet - EU West 1a"
   type = string
}

variable "private_subnet_cidr_euw1b" {
   description = "CIDR Range for private subnet - EU West 1b"
   type = string
}