variable "user_name" {
  description = "The user name to use"
  type = string
}

variable "give_cloudwatch_full_access" {
  description = "If true, provide full access to CloudWatch service"
  type        = bool
}