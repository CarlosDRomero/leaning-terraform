locals {
  common_tags = {
    Environment = "Dev"
    Owner       = "CDROM"
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr

  tags = merge(local.common_tags, {
    Name = "MAIN_VPC"
  })
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "Public Subnet"
  })
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet

  tags = merge(local.common_tags, {
    Name = "Private Subnet"
  })
}