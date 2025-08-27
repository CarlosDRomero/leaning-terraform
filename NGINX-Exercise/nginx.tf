provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "server" {
    # He decidido usar la imagen de Ubuntu Server 24.04 LTS (64-bit (x86))
    ami = "ami-0cfde0ea8edd312d4"
    instance_type = "t3.micro"
    user_data = file("userdata.sh")
    key_name = aws_key_pair.ssh-kp.key_name
    vpc_security_group_ids = [ aws_security_group.server-sg.id ]
}

resource "aws_key_pair" "ssh-kp" {
    key_name = "ssh-nginx"
    public_key = file("nginx-server.pub")
}

resource "aws_security_group" "server-sg"{
    name = "server-sg"
    description = "Grupo para permitir conexiones SSH y HTTP en la instancia de EC2"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        to_port = 0
        from_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}