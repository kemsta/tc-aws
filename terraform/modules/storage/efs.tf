resource "aws_efs_file_system" "this" {
  creation_token = "${var.stage_tag}-efs-${random_id.this.hex}"

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-efs-${random_id.this.hex}"
  })
}

resource "aws_efs_mount_target" "mount_target" {
  for_each        = toset(var.subnet_ids)
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = each.key
  security_groups = [aws_security_group.efs.id]
}

resource "aws_security_group" "efs" {
  vpc_id = var.vpc_id

  ingress {
    protocol        = "TCP"
    from_port       = 2049
    to_port         = 2049
    security_groups = var.source_security_group_ids
  }

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-efs-sg"
  })
}