resource "aws_efs_file_system" "this" {
  creation_token = "${var.stage_tag}-efs-${random_id.this.hex}"

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-efs-${random_id.this.hex}"
  })

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_efs_mount_target" "mount_target" {
  for_each        = var.private_networks
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = each.value.id
  security_groups = [aws_security_group.efs.id]
}

resource "aws_security_group" "efs" {
  vpc_id = var.vpc_id

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-efs-sg"
  })
}