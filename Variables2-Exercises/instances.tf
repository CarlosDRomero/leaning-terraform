resource "aws_instance" "public_ec2" {
  ami = var.ec2_configuration.ami
  instance_type = var.ec2_configuration.instance_type
  subnet_id = aws_subnet.public_subnet.id

  key_name = data.aws_key_pair.ec2key.key_name

  tags = {
    Name = "PUBLIC_EC2"
  }

}