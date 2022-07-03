variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "The size of the DB instance"
  type        = string
  default     = "db.t2.micro"
}

variable "engine" {
  description = "The Database Engine to use."
  type        = string
  default     = "mysql"
}

variable "identifier_prefix" {
  description = "Prefix for the RDS instance name"
  type        = string
}

variable "allocated_storage" {
  description = "Amount of disk space to allocate for databse data"
  type        = number
  default     = 10
}

variable "skip_final_snapshot" {
  description = "Don't take snapshot while destroying the database"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "publicly_accessible" {
  description = "Access database instance through internet"
  type        = bool
  default     = false
}