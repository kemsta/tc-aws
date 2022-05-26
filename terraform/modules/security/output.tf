output "server_pods_sg" {
  value = aws_security_group.server-pods.id
}

output "agent_pods_sg" {
  value = aws_security_group.agent-pods.id
}
