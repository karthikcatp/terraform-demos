provider "aws" {
  region = "ap-south-1"
}

module "mysql_cluser" {
  source = "../../modules/data-stores/mysql"

  db_name             = "lmsprod"
  db_password         = "rajan123"
  db_username         = "rajan"
  identifier_prefix   = "lmsprod"
  publicly_accessible = false
  skip_final_snapshot = true
}

