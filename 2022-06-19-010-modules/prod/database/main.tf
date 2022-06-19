provider "aws" {
  region = "ap-south-1"
}

module "mysql_cluser" {
  source = "github.com/rathinamtrainers/terraform-demos/tree/master/2022-06-19-010-modules/modules/data-stores/mysql?ref=1.0"

  db_name             = "lmsprod"
  db_password         = "rajan123"
  db_username         = "rajan"
  identifier_prefix   = "lmsprod"
  publicly_accessible = false
  skip_final_snapshot = true
}

