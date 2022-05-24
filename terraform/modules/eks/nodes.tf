resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${aws_eks_cluster.this.name}-nodes"
  node_role_arn   = aws_iam_role.node.arn
  instance_types  = var.instance_types
  subnet_ids      = values(var.private_networks)[*].id

  scaling_config {
    desired_size = var.nodes_desired_size
    max_size     = var.nodes_max_size
    min_size     = var.nodes_min_size
  }

  lifecycle {
    create_before_destroy = true
  }
}
