resource "aws_db_instance" "this" {
  identifier                  = "${var.stage_tag}-postgres-db"
  engine                      = "postgres"
  instance_class              = var.db_instance_class
  engine_version              = var.db_engine_version
  auto_minor_version_upgrade  = false
  allow_major_version_upgrade = false
  skip_final_snapshot         = true

  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage

  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.allow_postgres.id]

  username = "postgres"
  password = random_password.password.result

  tags = var.default_tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_db_subnet_group" "this" {
  subnet_ids = var.subnet_ids

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-db-subnet-group"
  })
}

resource "aws_security_group" "allow_postgres" {
  description = "Allow postgres inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = var.source_security_group_ids
  }

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-postgres-sg"
  })
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
