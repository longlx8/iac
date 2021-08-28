# khai báo provider, xác thực
provider "aws" {
  access_key = "**********"
  secret_key = "**********"
  region     = "ap-southeast-1" # Singapore region
}

# tạo s3 bucket
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "devops-techmaster-03-longlx"
  acl    = "private"
}
