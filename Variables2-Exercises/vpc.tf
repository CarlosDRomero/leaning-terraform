resource "aws_vpc" "main" {
  cidr_block = var.cidr

  tags = {
    Name        = "MAIN_VPC"
    Environment = "Dev"
    Owner       = "CDROM"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet
}