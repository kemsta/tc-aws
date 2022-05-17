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
  vpc_id       = module.network.vpc_id
  stage_tag    = var.stage_tag
  default_tags = local.default_tags
  cluster_name = local.cluster_name
}


module "eks" {
  source            = "./modules/eks"
  public_subnet_ids = values(module.network.public_networks)[*].id
  cluster_role_arn  = module.security.cluster_role_arn
  cluster_name      = local.cluster_name
  kuber_version     = var.kuber_version

  private_subnet_ids = values(module.network.private_networks)[*].id
  node_role_arn      = module.security.node_role_arn

  eks_workers_agents_sg_ids = [module.security.eks_workers_agents_sg.id]
  eks_control_plane_sg_ids  = [module.security.eks_control_plane_sg.id]
}

module "storage" {
  source                    = "./modules/storage"
  stage_tag                 = var.stage_tag
  default_tags              = local.default_tags
  subnet_ids                = values(module.network.private_networks)[*].id
  source_security_group_ids = [module.eks.EKS_CLuster.vpc_config[0].cluster_security_group_id]
  vpc_id                    = module.network.vpc_id
}
