locals {
  cluster_name = "${var.stage_tag}-eks-cluster"
  default_tags = {
    "stage"      = var.stage_tag
    "managed_by" = "terraform"
  }
}

module "network" {
  source       = "./modules/network"
  default_tags = local.default_tags
  cluster_name = local.cluster_name
  vpc-cidr     = var.vpc-cidr
  max_azs      = var.max_azs
  stage_tag    = var.stage_tag
}

