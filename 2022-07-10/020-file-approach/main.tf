provider "aws" {
  region = "ap-south-1"
}

terraform {
  # Reference: https://www.terraform.io/language/settings/backends/s3
  backend "s3" {
    bucket = "rtc2022q3-terraform-state-1"
    key = "secretdemo/terraform.tfstate"
    region = "ap-south-1"

    dynamodb_table = "terrform_locks"
    encrypt = true
  }
}


resource "aws_db_instance" "lmsdb" {
  instance_class      = var.instance_class
  engine              = var.engine
  identifier_prefix   = var.identifier_prefix
  allocated_storage   = var.allocated_storage
  skip_final_snapshot = var.skip_final_snapshot
  db_name             = var.db_name
  publicly_accessible = var.publicly_accessible

  username            = local.db_creds.username
  password            = local.db_creds.password
}

data "aws_kms_secrets" "creds" {
  secret {
    name    = "db"
    payload = file("${path.module}/db-creds.yml.encrypted")
  }
}

locals {
  db_creds = yamldecode(data.aws_kms_secrets.creds.plaintext["db"])
}

