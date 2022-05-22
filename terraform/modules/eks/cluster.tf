resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.kuber_version


  vpc_config {
    endpoint_public_access  = true
    endpoint_private_access = true
    subnet_ids              = values(var.public_networks)[*].id
    public_access_cidrs     = var.public_access_cidrs
  }

  tags = var.default_tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_eks_addon" "kube-proxy" {
  addon_name               = "kube-proxy"
  addon_version            = var.kube_proxy_version
  cluster_name             = aws_eks_cluster.this.name
  service_account_role_arn = aws_iam_role.cluster.arn
  resolve_conflicts        = "OVERWRITE"
}
resource "aws_eks_addon" "vpc-cni" {
  addon_name        = "vpc-cni"
  addon_version     = var.vpc_cni_version
  cluster_name      = aws_eks_cluster.this.name
  resolve_conflicts = "OVERWRITE"
}

resource "aws_eks_addon" "coredns" {
  addon_name        = "coredns"
  addon_version     = var.coredns_version
  cluster_name      = aws_eks_cluster.this.name
  resolve_conflicts = "OVERWRITE"
}

data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.this.name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}


resource "kubernetes_role" "vpc-cni-deployment-patcher" {
  metadata {
    name      = "vpc-cni-deployment-patcher"
    namespace = "kube-system"
  }
  rule {
    api_groups     = ["apps"]
    resources      = ["daemonsets"]
    resource_names = ["aws-node"]
    verbs          = ["get", "patch"]
  }
}

resource "kubernetes_service_account" "vpc-cni-deployment-patcher" {
  metadata {
    name      = "vpc-cni-deployment-patcher"
    namespace = "kube-system"
  }
}

resource "kubernetes_role_binding" "vpc-cni-deployment-patcher" {
  metadata {
    name      = "vpc-cni-deployment-patcher"
    namespace = "kube-system"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "vpc-cni-deployment-patcher"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "vpc-cni-deployment-patcher"
    namespace = "kube-system"
  }
}

resource "kubernetes_job" "vpc-cni-set-env" {
  depends_on = [
    aws_eks_addon.vpc-cni
  ]
  metadata {
    name      = "vpc-cni-set-env"
    namespace = "kube-system"
  }
  spec {
    template {
      metadata {}
      spec {
        service_account_name = kubernetes_service_account.vpc-cni-deployment-patcher.metadata[0].name
        container {
          name    = "vpc-cni-set-env"
          image   = "bitnami/kubectl:latest"
          command = ["/bin/sh", "-c", "kubectl set env daemonset aws-node -n kube-system ENABLE_POD_ENI=true POD_SECURITY_GROUP_ENFORCING_MODE=standard"]
        }
        restart_policy = "Never"
      }
    }
  }
  wait_for_completion = true
  timeouts {
    create = "5m"
  }
}
