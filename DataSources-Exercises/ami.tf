data "aws_ami" "retrieved_ami" {
  most_recent = true
  owners      = ["099720109477"]
}


data "aws_caller_identity" "admin" {}
data "aws_region" "region" {}

output "ubuntu_ami_data" {
  value = data.aws_ami.retrieved_ami.id
}

output "id" {
  value = data.aws_caller_identity.admin
}
output "region" {
  value = data.aws_region.region
}