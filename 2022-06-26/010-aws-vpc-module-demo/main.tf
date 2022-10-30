locals {
  region = "ap-south-1"
}

provider "aws" {
  region = local.region
}

################################################################################
# VPC Module
################################################################################

module "vpc_example_complete-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "myvpc1"
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_ipv6 = true

  enable_nat_gateway = false
  single_nat_gateway = true

  public_subnet_tags = {
    Name = "rtc-vpc1-public"
  }

  tags = {
    Owner       = "Rajan"
    Environment = "Training"
  }

  vpc_tags = {
    Name = "rtc-vpc1"
  }
}