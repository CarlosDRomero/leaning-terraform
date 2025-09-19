variable "cidr" {
  type        = string
  description = "CIDR para la VPC"
  sensitive   = false
}

variable "public_subnet" {
  type        = string
  description = "CIDR de Public Subnet"
}
variable "private_subnet" {
  type        = string
  description = "CIDR de Private Subnet"
}
