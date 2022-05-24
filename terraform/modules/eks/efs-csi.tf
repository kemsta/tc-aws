provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

resource "helm_release" "aws-efs-csi-driver" {
  name       = "aws-efs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  chart      = "aws-efs-csi-driver"
  namespace  = "kube-system"
  wait       = false

  values = [
    templatefile(
      "${path.module}/template/storage_class.tmpl",
      {
        efs_id = "${var.efs_id}"
      }
    )
  ]
  depends_on = [
    aws_eks_addon.vpc-cni,
    aws_eks_addon.kube-proxy
  ]
}
