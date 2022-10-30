provider "aws" {
  region = "ap-south-1"
  alias = "parent"
}

provider "aws" {
  region = "ap-south-1"
  alias = "child"

  assume_role {
    role_arn = "arn:aws:iam::468183264038:role/OrganizationAccountAccessRole"
  }
}
module "multi_account_demo" {
  source = "../modules/multi-account"

  providers = {
    aws.parent = aws.parent
    aws.child = aws.child
  }
}
