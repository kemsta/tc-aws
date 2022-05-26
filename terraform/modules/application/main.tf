
resource "helm_release" "teamcity" {
  chart            = "../tc-chart"
  name             = var.stage_tag
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "securityGroups.server"
    value = var.server_pods_sg
  }

  set {
    name  = "securityGroups.agents"
    value = var.agent_pods_sg
  }

  set {
    name  = "persistency.data.storageClassName"
    value = "efs-sc"
  }

  set {
    name  = "ingress.host"
    value = var.hostname
  }

  set {
    name  = "initialized"
    value = var.initialized
  }
}

resource "kubernetes_config_map_v1_data" "aws-auth" {
  depends_on = [
    helm_release.teamcity
  ]
  data = {
    "mapRoles" = <<EOT
- rolearn: ${var.node_role_arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
EOT
    "mapUsers" = <<EOT
- userarn: ${var.agent_user_arn}
  username: ${var.agent_user_name}
EOT
  }

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  force = true
}
