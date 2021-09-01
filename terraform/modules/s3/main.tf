# tạo s3 bucket
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "my_bucket" {
  
  bucket = var.bucket_name
  acl    = var.bucket_acl
  tags   = var.tags
}