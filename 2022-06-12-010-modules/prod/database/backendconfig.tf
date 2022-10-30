terraform {
  # Reference: https://www.terraform.io/language/settings/backends/s3
  backend "s3" {
    bucket = "rtc2022q3-terraform-state-1"
    key = "prod/data-stores/mysql/terraform.tfstate"
    region = "ap-south-1"

    dynamodb_table = "terrform_locks"
    encrypt = true
  }
}
