provider "aws" {
  region = "ap-south-1"
}


resource "aws_db_instance" "lmsdb" {
  instance_class      = "db.t2.micro"
  engine              = "mysql"
  identifier_prefix   = "lms"
  allocated_storage   = 10
  skip_final_snapshot = true
  db_name             = "lms"
  username            = var.db_username
  password            = var.db_password
  publicly_accessible = true
}