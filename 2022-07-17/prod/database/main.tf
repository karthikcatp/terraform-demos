provider "aws" {
  region = "ap-south-1"
  alias = "primary"
}

provider "aws" {
  region = "us-east-2"
  alias = "replica"
}

module "mysql_primary" {
  source = "../../modules/data-stores/mysql"

  providers = {
    aws = aws.primary
  }

  db_name             = "lmsprod"
  db_username         = "rajan"
  db_password         = "rajan123"
  identifier_prefix   = "lmsprodprimary"
  publicly_accessible = false
  skip_final_snapshot = true

  backup_retention_period = 1
}

module "mysql_replica" {
  source = "../../modules/data-stores/mysql"

  providers = {
    aws = aws.replica
  }

  identifier_prefix       = "lmsprodreplica"
  skip_final_snapshot = true

  replicate_source_db = module.mysql_primary.arn
}

