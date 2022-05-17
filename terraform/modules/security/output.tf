output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.node.arn
}

output "eks_workers_agents_sg" {
  value = aws_security_group.eks_agents_workers_group
}

output "eks_control_plane_sg" {
  value = aws_security_group.eks_control_plane
}
