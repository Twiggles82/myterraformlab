variable "tf_project_code" {
  description = "Project Code"
  type        = string
  default = "SGproject"
}

variable "vpc_name" {
   description = "The name of the VPC"
   type = string
   default = "sgvpc"
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
  default = "10.180.24.0/22"
}

variable "private_subnet_euw1a" {
  description = "Private Subnet for eu-west-1a"
  type        = string
  default = "10.180.25.0/25"
}

variable "private_subnet_euw1b" {
  description = "Private Subnet for eu-west-1b"
  type        = string
  default = "10.180.26.0/25"
}

variable "public_subnet_euw1a" {
  description = "Public Subnet for eu-west-1a"
  type        = string
  default = "10.180.25.128/25"
}

variable "public_subnet_euw1b" {
  description = "Public Subnet for eu-west-1b"
  type        = string
  default = "10.180.26.128/25"
}
