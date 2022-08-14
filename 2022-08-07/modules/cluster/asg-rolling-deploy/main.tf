terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_security_group" "instance" {
  name = "${var.cluster_name}-instance"
}


data "aws_ec2_instance_type" "instance" {
  instance_type = var.instance_type
}

resource "aws_launch_configuration" "lc" {
  image_id        = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.instance.id]
  user_data       = var.user_data

  # Required when using launch configuration with an ASG.
  lifecycle {
    create_before_destroy = true
    /*
    precondition {
      condition = data.aws_ec2_instance_type.instance.free_tier_eligible
      error_message = "${var.instance_type} is not part of the AWS free tier!"
    }*/
  }
}