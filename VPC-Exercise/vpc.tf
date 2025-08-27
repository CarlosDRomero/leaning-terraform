terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws"{
    region = "us-east-2"
}

resource "aws_vpc" "test_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "test_igw" {
    vpc_id = aws_vpc.test_vpc.id

}

resource "aws_route_table" "test_rt" {
    vpc_id = aws_vpc.test_vpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.test_igw.id
    }
}

resource "aws_route_table_association" "public_subnet_table" {
    route_table_id = aws_route_table.test_rt.id
    subnet_id = aws_subnet.public_subnet.id
}