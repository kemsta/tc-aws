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

module "security" {
  source       = "./modules/security"
  stage_tag    = var.stage_tag
  default_tags = local.default_tags
}


module "eks" {
  source             = "./modules/eks"
  subnet_ids         = values(module.network.public_networks)[*].id
  cluster_role_arn   = module.security.cluster_role_arn
  cluster_name       = local.cluster_name
  kuber_version      = var.kuber_version
}
