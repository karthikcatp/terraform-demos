
output "alb_dns_name" {
  value = aws_lb.weserver-lb.dns_name
  description = "The domain name of the webserver LB"
}

