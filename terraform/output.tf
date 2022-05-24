output "db_password" {
  value     = module.storage.db_password
  sensitive = true
}

output "db_endpoint" {
  value = module.storage.db_endpoint
}
