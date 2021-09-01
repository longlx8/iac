provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "devops-techmaster-03-terraform-state"
    dynamodb_table = "terraform-state-locking"
    key            = "registry_example/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}
