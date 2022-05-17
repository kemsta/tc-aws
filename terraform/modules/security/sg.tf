resource "aws_security_group" "eks_agents_workers_group" {
  vpc_id = var.vpc_id
  ingress {
    protocol        = "tcp"
    from_port       = 0
    to_port         = 65535
    security_groups = [aws_security_group.eks_control_plane.id]
  }

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-eks-agents-worker-sg"
    "kubernetes.io/cluster/${var.cluster_name}" : "owned"
  })
}

resource "aws_security_group_rule" "worker2worker" {
  type                     = "ingress"
  security_group_id        = aws_security_group.eks_agents_workers_group.id
  protocol                 = "-1"
  to_port                  = 0
  from_port                = 0
  source_security_group_id = aws_security_group.eks_agents_workers_group.id
}

resource "aws_security_group" "eks_control_plane" {
  vpc_id = var.vpc_id
  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-eks-control-sg"
  })
}

resource "aws_security_group_rule" "workers2control" {
  type                     = "ingress"
  security_group_id        = aws_security_group.eks_control_plane.id
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.eks_agents_workers_group.id
}

resource "aws_security_group_rule" "control2workers_egress" {
  type                     = "egress"
  security_group_id        = aws_security_group.eks_agents_workers_group.id
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.eks_control_plane.id
}
