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
resource "aws_instance" "nginx_server" {
  ami = "ami-0cfde0ea8edd312d4"
  instance_type = "t3.micro"
  user_data = file("userdata.sh")
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
}
resource "aws_security_group" "nginx_sg" {
  ingress {
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    to_port = 443
    from_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
