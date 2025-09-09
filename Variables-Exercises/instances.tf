resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  root_block_device {
    delete_on_termination = true
    volume_type           = var.ec2_configuration.type
    volume_size           = var.ec2_configuration.size
  }
  tags = {
    Name = "ubuntu-ec2"
    Env  = "Test"
  }
}