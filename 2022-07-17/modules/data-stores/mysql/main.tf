terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

resource "aws_db_instance" "lmsdb" {
  instance_class      = var.instance_class
  identifier_prefix   = var.identifier_prefix
  allocated_storage   = var.allocated_storage
  skip_final_snapshot = var.skip_final_snapshot
  publicly_accessible = var.publicly_accessible

  # Enable backups
  backup_retention_period = var.backup_retention_period

  # If specified, this DB will be a replica.
  replicate_source_db = var.replicate_source_db

  # Only set these parameters if replicate_source_db is not set.
  engine   = var.replicate_source_db == null ? var.engine : null
  db_name  = var.replicate_source_db == null ? var.db_name : null
  username = var.replicate_source_db == null ? var.db_username : null
  password = var.replicate_source_db == null ? var.db_password : null

}