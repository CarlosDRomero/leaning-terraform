provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "vpc" {
  cidr_block = "3.4.0.0/16"
}
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "3.4.2.0/24"
}
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "3.4.1.0/24"
}
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id  
}
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route{
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gateway.id
  }
}
