region = "ap-south-1"
ami = "ami-079b5e5b3971bd10d"
tags = {
    "Name" = "webserver"
    "Application" = "CRM"
}
ingress_source_cidr = ["182.75.184.32/29", "0.0.0.0/0"]
