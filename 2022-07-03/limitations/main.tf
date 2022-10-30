provider "aws" {
  region = "ap-south-1"
}

resource "random_integer" "num_instances" {
  min = 1
  max = 3
}

resource "aws_instance" "example_3" {
  count         = random_integer.num_instances.result
  ami           = "ami-079b5e5b3971bd10d"
  instance_type = "t2.micro"
}

