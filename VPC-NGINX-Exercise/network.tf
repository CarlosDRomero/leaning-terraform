resource "aws_vpc" "vpc" {
  cidr_block = "3.4.0.0/16"
  tags = merge(local.common_tags, {
    Name = "VPC-NGINX"
  })
}
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "3.4.2.0/24"
  tags = merge(local.common_tags, {
    Name = "VPC-NGINX-PUBLIC"
  })
}
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "3.4.1.0/24"
  tags = merge(local.common_tags, {
    Name = "VPC-NGINX-PRIVATE"
  })
}
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(local.common_tags, {
    Name = "VPC-NGINX-GTW"
  })
}
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = merge(local.common_tags, {
    Name = "VPC-NGINX-MAIN"
  })
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}