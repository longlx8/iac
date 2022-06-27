# khai báo provider, xác thực
# https://registry.terraform.io/providers/hashicorp/aws/latest

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.20.1"
    }
  }
}

provider "aws" {
  region     = "ap-southeast-1" # Singapore region
}

# tạo s3 bucket
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "my_bucket" {
  bucket = "devops-techmaster-03-longlx"
  acl    = "private"
}
