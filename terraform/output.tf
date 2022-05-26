output "db_password" {
  value     = module.storage.db_password
  sensitive = true
}

output "agent_user_id" {
  value = module.eks.agent_user_key.id
}

output "agent_user_secret" {
  value     = module.eks.agent_user_key.secret
  sensitive = true
}

output "s3_user_id" {
  value = module.storage.s3_user_key.id
}

output "s3_user_secret" {
  value     = module.storage.s3_user_key.secret
  sensitive = true
}

output "initialize" {
  value = templatefile("./templates/initialize.md.tpl",
    {
      cluster_name : local.cluster_name
      namespace : var.namespace
      stage_tag : var.stage_tag
      db_username : var.db_username
      db_endpoint : module.storage.db_endpoint
      eks_endpoint : module.eks.cluster.endpoint
      agent_access_id : module.eks.agent_user_key.id
      s3_access_id : module.storage.s3_user_key.id
      s3_bucket_name : module.storage.s3_bucket.id
    }
  )
}