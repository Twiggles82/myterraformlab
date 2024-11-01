variable "tf_project_code" {
  description = "Project Code"
  type        = string
  default     = "SGproject"  # Default value
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "sgvpc"      # Default value
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
  default     = "10.0.0.0/16"  # Default value
}

variable "desktop_root_ebs_type" {
   description = "The system drive (C:) type for the Virtual Desktop Instances"
   type = string
   default = "gp3"
}

variable "desktop_root_ebs_size" {
   description = "The system drive (C:) size for the Virtual Desktop Instances"
   type = number
   default = "40"
}

variable "desktop_ami" {
   description = "The AMI Id for the desktop Instance"
   type = string
   default = "ami-002250a255c73da6e"
}

