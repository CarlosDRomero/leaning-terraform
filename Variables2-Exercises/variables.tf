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

variable "ec2_configuration" {
  type = object({
    ami = string
    instance_type = string
  })

  description = "Configuraciones para las instancias ec2"

}
