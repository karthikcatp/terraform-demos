provider "aws" {
  region = "ap-south-1"
}

module "users" {
  source = "../modules/iam_user"

  for_each = toset(var.usernames)
  user_name = each.value
}