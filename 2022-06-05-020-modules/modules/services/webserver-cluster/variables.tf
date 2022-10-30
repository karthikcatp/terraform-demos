variable "region" {
  type = string
  description = "Region to deploy the infrastructure resources"

  validation {
    condition = contains(["ap-south-1", "us-east-1"], lower(var.region))
    error_message = "Only Mumbai and N.Virginia regions are supported."
  }
}

variable "ami" {
  type = string
  description = "VM image to use"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "Size of the VM"
}

variable "tags" {
  type = map(string)
  description = "Tags to categorize the VM"
}

variable "ingress_source_cidr" {
  type = list(string)
  description = "Security Group ingress rules' source CIDR ranges"
}

variable "min_server_count" {
  type = number
}

variable "max_server_count" {
  type = number
}