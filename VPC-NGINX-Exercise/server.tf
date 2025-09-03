resource "aws_instance" "nginx_server" {
  ami           = "ami-0657db37a458d2230"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }
  user_data              = file("userdata.sh")
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]

  lifecycle {
    // Esto permite tener menos tiempo de baja en la máquina, cuando debe ser reemplazada.
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = "VPC-NGINX-EC2"
  })

}
resource "aws_security_group" "nginx_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "public-traffic"
  ingress {
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    to_port     = 443
    from_port   = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, {
    Name = "VPC-NGINX-SG"
  })
}
