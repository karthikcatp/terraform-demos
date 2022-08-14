terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.12.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  alias = "us"
}

provider "aws" {
  region = "ap-south-1"
  alias = "india"
}

data "aws_region" "us_region" {
  provider = aws.us
}

data "aws_region" "india_region" {
  provider = aws.india
}

data "aws_ami" "ubuntu_us" {
  provider = aws.us
  owners = ["099720109477"]  # Canonical
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "ubuntu_india" {
  provider = aws.india
  owners = ["099720109477"]  # Canonical
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "vm_in_india" {
  provider = aws.india

  ami = data.aws_ami.ubuntu_india.id
  instance_type = "t2.micro"
}

resource "aws_instance" "vm_in_us" {
  provider = aws.us

  ami = data.aws_ami.ubuntu_us.id
  instance_type = "t2.micro"
}


output "us" {
  value = join(",", [data.aws_region.us_region.name, data.aws_region.us_region.endpoint, data.aws_region.us_region.description])
  description = "Name of US region"
}

output "india" {
  value = join(",", [data.aws_region.us_region.name, data.aws_region.us_region.endpoint, data.aws_region.us_region.description])
  description = "Name of India region"
}

output "instance_us_az" {
  value = aws_instance.vm_in_us.availability_zone
  description = "The AZ where US instance is deployed"
}

output "instance_india_az" {
  value = aws_instance.vm_in_india.availability_zone
  description = "The AZ where Indian instance is deployed"
}