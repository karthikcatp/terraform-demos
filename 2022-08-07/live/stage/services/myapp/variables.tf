variable "instance_type" {
  description = "The type of EC2 instnace to run (e.g t2.micro)"
  type        = string
}

variable "environment" {
  description = "The name of the environment we are deploying to"
  type        = string
}