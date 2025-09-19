terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6"

    }
  }
}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = local.common_tags
  }
}

locals {
  common_tags = {
    Environment = "Dev"
    Owner       = "CDROM"
  }
}