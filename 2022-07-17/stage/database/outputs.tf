output "address" {
  value = module.mysql_cluser.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value = module.mysql_cluser.port
  description = "The port the database is listening on"
}