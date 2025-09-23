resource "aws_vpc" "main" {
  cidr_block = var.cidr

  tags = {
    Name = "MAIN_VPC"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet

  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_internet_gateway" "vpc_igw" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name="MAIN_VPC_IGW"
    }
}

resource "aws_route_table" "custom_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
      Name="MAIN_VPC_RT"
    }
}

resource "aws_route_table_association" "association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id =  aws_route_table.custom_rt.id
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh_conn"
  vpc_id = aws_vpc.main.id
  
  ingress {
    description = "Permitir SSH desde el internet"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "PUBLIC_SSH_SC"
  }
}