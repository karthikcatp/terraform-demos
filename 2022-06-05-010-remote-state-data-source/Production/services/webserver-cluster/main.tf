# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs#argument-reference
provider "aws" {
  region = var.region
}

# Reference: https://www.terraform.io/language/data-sources
data "aws_vpc" "default-vpc" {
  default = true
}

data "aws_subnets" "default-subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default-vpc.id]
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "rtc2022q3-terraform-state-1"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "ap-south-1"
  }
}

# API Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration
resource "aws_launch_configuration" "webserver-lc" {
  name = "webserver-lc"
  image_id      = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.webserver-lc-sg.id]
  associate_public_ip_address = true
  user_data = templatefile("user-data.sh", {
    db_address = data.terraform_remote_state.db.outputs.address
    db_port = data.terraform_remote_state.db.outputs.port
  } )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "webserver-lc-sg" {
  name = "webserver-lc-sg"
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = var.ingress_source_cidr
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = var.ingress_source_cidr
  }
  ingress {
    from_port = -1
    to_port   = -1
    protocol  = "icmp"
    cidr_blocks = var.ingress_source_cidr
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# API Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
resource "aws_autoscaling_group" "webserver-asg" {
  launch_configuration = aws_launch_configuration.webserver-lc.name
  vpc_zone_identifier = data.aws_subnets.default-subnets.ids

  target_group_arns = [aws_lb_target_group.webserver-lb-tg.id]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "webserver"
  }
}

# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "weserver-lb" {
  name = "webserver-lb"
  load_balancer_type = "application"
  subnets = data.aws_subnets.default-subnets.ids
  security_groups = [aws_security_group.alb-sg.id]
}

resource "aws_lb_listener" "listener-http" {
  load_balancer_arn = aws_lb.weserver-lb.arn
  port = 80
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code = 404
    }
  }
}

# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule
resource "aws_lb_listener_rule" "webserver-asg-rule" {
  listener_arn = aws_lb_listener.listener-http.arn
  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.webserver-lb-tg.arn
  }
  condition {}
}

resource "aws_security_group" "alb-sg" {
  name = "webserver-alb-sg"

  # Allow ingress HTTP traffic
  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all egress traffic
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "webserver-lb-tg" {
  name = "webserver-lb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = data.aws_vpc.default-vpc.id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    unhealthy_threshold = 2
    healthy_threshold = 2
  }
}

