provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myvm1"{
  ami = "ami-01216e7612243e0ef"
  instance_type = "t2.micro"
  user_data = <<-EOF


  tags = {
    Name = "webserver1"
    Application = "CRM"
  }
}

