# khai báo provider
provider "aws" {
  region = "ap-southeast-1"
}

# gọi module s3 từ đường dẫn local và truyền các giá trị vào
module "s3_bucket" {
  source = "../../modules/s3"

  bucket_name = "devops-techmaster-03-testing-bucket"
  bucket_acl  = "authenticated-read"

  tags = {
    Env = "testing"
  }
}

# in ra output của s3 module
output "s3_bucket_name" {
  value = module.s3_bucket.name
}
