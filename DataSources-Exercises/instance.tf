# resource "aws_instance" "ec2-ami" {
#   ami           = data.aws_ami.retrieved_ami.id
#   instance_type = "t3.micro"
#   root_block_device {
#     volume_size = 10
#     volume_type = "gp3"
#     delete_on_termination = true
#   }
# }