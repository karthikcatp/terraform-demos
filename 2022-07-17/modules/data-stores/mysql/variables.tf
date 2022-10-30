variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
  default = null
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
  default = null
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
  description = "Amount of disk space to allocate for database data"
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
  default = null
}

variable "publicly_accessible" {
  description = "Access database instance through internet"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  type = number
  default = null
  description = "Days to retain backup. Must be > 0 to enable replication"
}

variable "replicate_source_db" {
  type = string
  default = null
  description = "If specified, replicate the RDS database at the given ARN"
}