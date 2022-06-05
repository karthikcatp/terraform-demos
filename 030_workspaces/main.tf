terraform {
  backend "s3" {
    bucket = "rtc2022q3-terraform-state-1"
    key = "workspaces-demo/terraform.tfstate"
    region = "ap-south-1"

    dynamodb_table = "terrform_locks"
    encrypt = true
  }
}

variable "region" {
  type = string
  default = "ap-south-1"
}

variable "ami" {
  type = string
  default = "ami-079b5e5b3971bd10d"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "testvm1" {
  ami = var.ami
  instance_type =  terraform.workspace == "staging" ?  "t2.medium" : "t2.micro"
}