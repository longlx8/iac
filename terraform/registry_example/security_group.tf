# gọi security-group module và truyền vào các tham số
# https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest/submodules/mysql

module "mysql_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/mysql"
  version = "~> 4.0"

  name                = "devops-03-mysql-sg"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["14.232.243.111/32"]
}