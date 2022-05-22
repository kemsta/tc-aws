output "db_password" {
  value     = module.storage.db_password
  sensitive = true
}

output "db_endpoint" {
  value = module.storage.db_endpoint
}

output "server_pods_sg" {
  value = module.security.server_pods_sg
}

output "agents_pods_sg" {
  value = module.security.agent_pods_sg
}