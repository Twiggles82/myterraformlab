variable "aws_access_key" {
   description = "AWS Access Key"
   default = ""
}

variable "aws_secret_key" {
   description = "AWS secret key"
   default = ""
}

variable "aws_region" {
   description = "AWS region"
   default = "eu-west-1"
}

variable "key_name" {
  description = "Private key for instances"
  default = "dxc-sandpit-sg-kp"
}

variable "ec2_profile" {
  description = "ec2 profile for permissions"
  default = "ec2_profile"
}