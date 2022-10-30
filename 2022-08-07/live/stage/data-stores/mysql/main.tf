terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # Reference: https://www.terraform.io/language/settings/backends/s3
  backend "s3" {
    bucket = "rtc2022q3-terraform-state-1"
    key = "project/stage/data-stores/mysql/terraform.tfstate"
    region = "ap-south-1"

    dynamodb_table = "terrform_locks"
    encrypt = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "mysql" {
  source = "../../../../modules/data-stores/mysql"
  db_name = var.db_name
  db_password = var.db_password
  db_username = var.db_username
}