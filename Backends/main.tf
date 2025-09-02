terraform {
    required_version = "1.13.0"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
      random = {
        source = "hashicorp/random"
        version = "~> 3.7"
      }
    }
    backend "s3" {
      bucket="terraform-backend-cdg25"
      key = "state.tfstate"
      region = "us-east-2"
    }
}
provider "aws" {
  region = "us-east-2"
}
resource "random_id" "bucket_id" {
    byte_length = 8
}
resource "aws_s3_bucket" "bucket" {
    bucket = "bucket-${random_id.bucket_id.hex}"
    tags = {
      Name="TestBucket"
    }
}

output "bucket_name" {
    value = aws_s3_bucket.bucket.bucket
}