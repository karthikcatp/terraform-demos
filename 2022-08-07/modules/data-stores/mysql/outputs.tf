output "address" {
  value       = aws_db_instance.dbinstance.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value = aws_db_instance.dbinstance.port
  description = "The port on which the database is listening on"
}