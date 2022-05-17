resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-nodes"
  node_role_arn   = var.node_role_arn
  instance_types  = var.instance_types
  subnet_ids      = var.private_subnet_ids
  version         = var.kuber_version

  scaling_config {
    desired_size = var.nodes_desired_size
    max_size     = var.nodes_max_size
    min_size     = var.nodes_min_size
  }

  depends_on = [
    aws_eks_cluster.this
  ]

  lifecycle {
    create_before_destroy = true
  }
}
