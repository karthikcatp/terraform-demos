provider "aws" {
  region = "ap-south-1"
}

module "mysql_cluser" {
  source = "github.com/rathinamtrainers/terraform-demos//2022-06-19-010-modules/modules/data-stores/mysql?ref=2.0"

  db_name             = "lms"
  db_password         = "rajan123"
  db_username         = "rajan"
  identifier_prefix   = "lms"
  publicly_accessible = true
  skip_final_snapshot = true
}

