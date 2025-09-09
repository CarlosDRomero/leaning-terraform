resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  root_block_device {
    delete_on_termination = true
    volume_type           = var.volume_type
    volume_size           = var.volume_size
  }
  tags = {
    Name = "ubuntu-ec2-${var.aws_region}"
    Env  = "Test"
  }
}