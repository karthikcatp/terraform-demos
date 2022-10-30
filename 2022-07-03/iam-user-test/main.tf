provider "aws" {
  region = "ap-south-1"
}

module "user1" {
  source = "../modules/iam_user"

  user_name = "user1"
  give_cloudwatch_full_access = false
}

module "user2" {
  source = "../modules/iam_user"

  user_name = "user2"
  give_cloudwatch_full_access = true
}