
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