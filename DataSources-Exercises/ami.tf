data "aws_ami" "retrieved_ami" {
  most_recent = true
  owners      = ["099720109477"]
}


data "aws_caller_identity" "admin" {}
data "aws_region" "region" {}

// Manejando recursos mediante tags, no incluidos en el proyecto
// Se creo una VPC manualmente desde la página de AWS que tiene el tag especificado aquí.
data "aws_vpc" "console_managed" {
  tags = {
    Env = "Prod"
  }  
}

data "aws_iam_policy_document" "get" {
  statement {
    sid = "PublicRead"
    principals {
      type = "*"
      identifiers = ["*"]
    }
    actions = ["s3:GetObject"]

    resources = [data.aws_vpc.console_managed.arn]
  }  
}

output "policy" {
  value = data.aws_iam_policy_document.get.json
}

output "console_managed" {
  value = data.aws_vpc.console_managed.arn
}


output "ubuntu_ami_data" {
  value = data.aws_ami.retrieved_ami.id
}

output "id" {
  value = data.aws_caller_identity.admin
}
output "region" {
  value = data.aws_region.region
}