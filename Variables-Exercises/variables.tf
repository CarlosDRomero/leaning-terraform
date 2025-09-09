variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
  validation {
    condition     = var.ec2_instance_type == "t3.small" || var.ec2_instance_type == "t3.micro"
    error_message = "Only t3.micro and t3.small are supported"
  }
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "volume_size" {
  type = number
}