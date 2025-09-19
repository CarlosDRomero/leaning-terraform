output "ec2_ip" {
  description = "IP pública asignada a la instancia"
  value = aws_instance.public_ec2.public_ip
}