terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

locals {
  common_tags = {
    ManagedBy = "Terraform"
    Project   = "VPC-NGINX"
  }
}