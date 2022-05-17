output "db_password" {
  value     = module.storage.db_password
  sensitive = true
}

output "db_host" {
  value = module.storage.db_host
}

output "db_port" {
  value = module.storage.db_port
}
