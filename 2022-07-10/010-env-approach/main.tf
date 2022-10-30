provider "aws" {
  region = "ap-south-1"
}

resource "aws_db_instance" "lmsdb" {
  instance_class      = var.instance_class
  engine              = var.engine
  identifier_prefix   = var.identifier_prefix
  allocated_storage   = var.allocated_storage
  skip_final_snapshot = var.skip_final_snapshot
  db_name             = var.db_name
  publicly_accessible = var.publicly_accessible

  username            = var.db_username
  password            = var.db_password
}