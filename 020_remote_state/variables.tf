variable "region" {
  type = string
  description = "Region to deploy the infrastructure resources"

  validation {
    condition = contains(["ap-south-1", "us-east-1"], lower(var.region))
    error_message = "Only Mumbai and N.Virginia regions are supported."
  }
}