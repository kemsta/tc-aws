output "s3_bucket" {
  value = aws_s3_bucket.this
}

output "db_host" {
  value = aws_db_instance.this.address
}

output "db_port" {
  value = aws_db_instance.this.port
}

output "db_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "db_password" {
  value     = random_password.password.result
  sensitive = true
}
