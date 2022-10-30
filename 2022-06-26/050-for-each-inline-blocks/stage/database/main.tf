provider "aws" {
  region = "ap-south-1"
}

module "mysql_cluser" {
  source = "../../../modules/data-stores/mysql"

  db_name             = "lms"
  db_password         = "rajan123"
  db_username         = "rajan"
  identifier_prefix   = "lms"
  publicly_accessible = true
  skip_final_snapshot = true
}

