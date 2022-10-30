locals {
  region = "ap-south-1"
}
provider "aws" {
  region = local.region
}

resource "aws_iam_user" "users" {
  for_each = toset(var.user_names)
  name = each.value
}

output "all_users" {
  value = aws_iam_user.users
}

output "all_arns" {
  value = values(aws_iam_user.users)[*].arn
}

