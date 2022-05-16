resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kuber_version


  vpc_config {
    endpoint_public_access  = true
    endpoint_private_access = true
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids
  }

  tags = var.default_tags

  lifecycle {
    prevent_destroy = true
  }
}
