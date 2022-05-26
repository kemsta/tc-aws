output "cluster" {
  value = aws_eks_cluster.this
}

output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.node.arn
}

output "agent_user_key" {
  value = aws_iam_access_key.agent_user_key
}

output "agent_user" {
  value = aws_iam_user.agent_user
}
