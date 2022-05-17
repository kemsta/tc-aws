resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kuber_version


  vpc_config {
    endpoint_public_access  = true
    endpoint_private_access = true
    subnet_ids              = var.public_subnet_ids
    security_group_ids      = var.eks_control_plane_sg_ids
  }

  tags = var.default_tags

  lifecycle {
    prevent_destroy = true
  }
}
