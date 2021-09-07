# cấu hình remote state với s3 bucket, locking với dynamodb table
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "devops-techmaster-03-terraform-state"
    dynamodb_table = "terraform-state-locking"
    key            = "production/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}
