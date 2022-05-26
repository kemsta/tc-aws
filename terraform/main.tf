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

module "storage" {
  source           = "./modules/storage"
  stage_tag        = var.stage_tag
  default_tags     = local.default_tags
  private_networks = module.network.private_networks
  vpc_id           = module.network.vpc_id

  db_allocated_storage     = var.db_allocated_storage
  db_max_allocated_storage = var.db_max_allocated_storage
  db_engine_version        = var.db_engine_version
  db_instance_class        = var.db_instance_class
  db_username              = var.db_username
}

module "eks" {
  source        = "./modules/eks"
  cluster_name  = local.cluster_name
  kuber_version = var.kuber_version

  public_networks  = module.network.public_networks
  private_networks = module.network.private_networks

  efs_id = module.storage.efs_id

  instance_types     = var.instance_types
  nodes_desired_size = var.nodes_desired_size
  nodes_min_size     = var.nodes_min_size
  nodes_max_size     = var.nodes_max_size

  kube_proxy_version     = var.kube_proxy_version
  vpc_cni_version        = var.vpc_cni_version
  coredns_version        = var.coredns_version
  ebs_csi_driver_version = var.ebs_csi_driver_version
}

module "security" {
  source         = "./modules/security"
  vpc_id         = module.network.vpc_id
  stage_tag      = var.stage_tag
  default_tags   = local.default_tags
  cluster_name   = local.cluster_name
  cluster_sg_id  = module.eks.cluster.vpc_config[0].cluster_security_group_id
  postgres_sg_id = module.storage.postgres_sg_id
  efs_sg_id      = module.storage.efs_sg_id
}


data "aws_eks_cluster_auth" "this" {
  name = local.cluster_name
  depends_on = [
    module.eks
  ]
}

data "aws_eks_cluster" "this" {
  name = local.cluster_name
  depends_on = [
    module.eks
  ]
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

module "application" {
  source          = "./modules/application"
  stage_tag       = var.stage_tag
  cluster_name    = local.cluster_name
  agent_pods_sg   = module.security.agent_pods_sg
  server_pods_sg  = module.security.server_pods_sg
  hostname        = var.hostname
  initialized     = var.initialized
  namespace       = var.namespace
  agent_user_name = module.eks.agent_user.name
  agent_user_arn  = module.eks.agent_user.arn
  node_role_arn   = module.eks.node_role_arn
  depends_on = [
    module.eks
  ]
}
