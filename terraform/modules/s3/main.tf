# tạo s3 bucket với các giá trị tham chiếu từ các biến của module (variables.tf)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

# keyword: var.

resource "aws_s3_bucket" "my_bucket" {
  
  bucket = var.bucket_name
  acl    = var.bucket_acl
  tags   = var.tags
}