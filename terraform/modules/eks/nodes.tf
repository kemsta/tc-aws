resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-nodes"
  node_role_arn   = var.node_role_arn
  instance_types  = var.instance_types
  subnet_ids      = var.private_subnet_ids
  version         = var.kuber_version

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_eks_cluster.this
  ]
}