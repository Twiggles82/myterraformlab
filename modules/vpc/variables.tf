variable "tf_project_code" {
  description = "Project Code"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
}

variable "public_subnet_cidr_euw1a" {
  description = "Public Subnet CIDR for eu-west-1a"
  type        = string
}

variable "public_subnet_cidr_euw1b" {
  description = "Public Subnet CIDR for eu-west-1b"
  type        = string
}

variable "private_subnet_cidr_euw1a" {
  description = "Private Subnet CIDR for eu-west-1a"
  type        = string
}

variable "private_subnet_cidr_euw1b" {
  description = "Private Subnet CIDR for eu-west-1b"
  type        = string
}
