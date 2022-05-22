resource "aws_security_group" "server-pods" {
  vpc_id = var.vpc_id

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-eks-server-pods-sg"
  })
}

resource "aws_security_group_rule" "cluster2server-pods_ALL_TCP" {
  security_group_id = aws_security_group.server-pods.id
  type              = "ingress"

  from_port                = 0
  to_port                  = 65535
  protocol                 = "TCP"
  source_security_group_id = var.cluster_sg_id
}

resource "aws_security_group_rule" "server-pods2cluster_DNS" {
  for_each                 = toset(["TCP", "UDP"])
  security_group_id        = var.cluster_sg_id
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = each.value
  source_security_group_id = aws_security_group.server-pods.id
}

resource "aws_security_group_rule" "server-pods2postgres_5432_TCP" {
  security_group_id        = var.postgres_sg_id
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.server-pods.id
}

resource "aws_security_group" "agent-pods" {
  vpc_id = var.vpc_id

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-eks-agent-pods-sg"
  })
}

resource "aws_security_group_rule" "cluster2agent-pods_ALL_TCP" {
  security_group_id = aws_security_group.agent-pods.id
  type              = "ingress"

  from_port                = 0
  to_port                  = 65535
  protocol                 = "TCP"
  source_security_group_id = var.cluster_sg_id
}

resource "aws_security_group_rule" "agent-pods2cluster_DNS" {
  for_each                 = toset(["TCP", "UDP"])
  security_group_id        = var.cluster_sg_id
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = each.value
  source_security_group_id = aws_security_group.agent-pods.id
}

resource "aws_security_group_rule" "cluster2efs_2049_TCP" {
  security_group_id        = var.efs_sg_id
  type                     = "ingress"
  protocol                 = "TCP"
  from_port                = 2049
  to_port                  = 2049
  source_security_group_id = var.cluster_sg_id
}
