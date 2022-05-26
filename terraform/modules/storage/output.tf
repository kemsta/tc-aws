output "s3_bucket" {
  value = aws_s3_bucket.this
}

output "db_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "db_password" {
  value     = random_password.password.result
  sensitive = true
}

output "postgres_sg_id" {
  value = aws_security_group.postgres.id
}

output "efs_sg_id" {
  value = aws_security_group.efs.id
}

output "efs_id" {
  value = aws_efs_file_system.this.id
}

output "s3_user_key" {
  value = aws_iam_access_key.s3_user_key
}