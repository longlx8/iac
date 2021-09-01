# gọi vpc module từ registry và truyền vào các tham số
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "devops-03"
  cidr = "10.9.0.0/16"

  azs              = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  private_subnets  = ["10.9.1.0/24", "10.9.2.0/24", "10.9.3.0/24"]
  public_subnets   = ["10.9.101.0/24", "10.9.102.0/24", "10.9.103.0/24"]
  database_subnets = ["10.9.21.0/24", "10.9.22.0/24", "10.9.23.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true
  enable_dns_hostnames                   = true
  enable_dns_support                     = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "database_subnets" {
  value = module.vpc.database_subnets
}
