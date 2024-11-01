variable "tf_project_code" {
  description = "Project Code"
  type        = string
}

variable "desktop_ami" {
   description = "The AMI Id for the desktop Instance"
   type = string
}

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

variable "key_pair" {
  description = "Private key for instances"
  default = "dxc-sandpit-sg-kp"
}

variable "ec2_profile" {
  description = "ec2 profile for permissions"
  default = "ec2_profile"
}

variable "desktop_instance_type" {
  description = "instance type for desktop"
  default = ""
}

variable "desktop_availability_zone" {
  description = "availability zone for desktop"
  default = ""
}

variable "desktop_root_ebs_type" {
   description = "The system drive (C:) type for the Virtual Desktop Instances"
   type = string
   default = ""
}

variable "desktop_root_ebs_size" {
   description = "The system drive (C:) size for the Virtual Desktop Instances"
   type = number
}

variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be deployed"
  type        = string
}