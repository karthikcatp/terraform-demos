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
    key = "project/stage/services/myapp/terraform.tfstate"
    region = "ap-south-1"

    dynamodb_table = "terrform_locks"
    encrypt = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "amazon_linux" {
  owners = ["137112412989"]  # Amazon
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


module "asg" {
  source = "../../../../modules/cluster/asg-rolling-deploy"

  ami           = data.aws_ami.amazon_linux.id
  cluster_name  = "lms-${var.environment}"
  instance_type = var.instance_type

  user_data = templatefile("${path.module}/user-data.sh", {} )
}