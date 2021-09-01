# gọi rds module từ terraform registry và truyền vào các tham số
# https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"

  identifier = "devops-03-mysql"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.micro"
  allocated_storage = 5

  name     = "devops-03"
  username = "dev"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "3306"

  # DB subnet group
  subnet_ids = module.vpc.database_subnets

  vpc_security_group_ids = [module.mysql_security_group.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"
  
  publicly_accessible  = true
  skip_final_snapshot  = true

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}

# in ra rds endpoint
output "rds_mysql_endpoint" {
  value = module.db.db_instance_endpoint
}
