cidr           = "10.11.0.0/16"
public_subnet  = "10.11.0.0/24"
private_subnet = "10.11.1.0/24"
ec2_configuration = {
  ami = "ami-0657db37a458d2230"
  instance_type = "t3.micro"
}