
locals {
  zones = { for idx, az in slice(sort(data.aws_availability_zones.available.names), 0, var.max_azs) : az => idx }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc-cidr

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-vpc"
  })
}

resource "aws_subnet" "public" {
  for_each = local.zones

  availability_zone       = each.key
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc-cidr, 8, each.value)
  map_public_ip_on_launch = true

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-${each.key}-public-subnet"
    "kubernetes.io/role/elb" : 1
    "kubernetes.io/cluster/${var.cluster_name}" : "shared"
  })
}

resource "aws_subnet" "private" {
  for_each = local.zones

  availability_zone = each.key
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc-cidr, 8, each.value + var.max_azs)

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-${each.key}-private-subnet"
    "kubernetes.io/role/internal-elb" : 1
    "kubernetes.io/cluster/${var.cluster_name}" : "shared"
  })
}

resource "aws_internet_gateway" "this" {
  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-igw"
  })
}

resource "aws_internet_gateway_attachment" "this" {
  vpc_id              = aws_vpc.this.id
  internet_gateway_id = aws_internet_gateway.this.id
}

resource "aws_eip" "this" {
  for_each = local.zones
  vpc      = true

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-eip-${each.key}"
  })
}

resource "aws_nat_gateway" "this" {
  for_each      = local.zones
  subnet_id     = lookup(aws_subnet.public, each.key).id
  allocation_id = lookup(aws_eip.this, each.key).id

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-nat-gw-${each.key}"
  })
}

resource "aws_route_table" "private" {
  vpc_id   = aws_vpc.this.id
  for_each = local.zones

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = lookup(aws_nat_gateway.this, each.key).id
  }

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-rt-private-${each.key}"
  })
}

resource "aws_route_table_association" "private" {
  for_each       = local.zones
  subnet_id      = lookup(aws_subnet.private, each.key).id
  route_table_id = lookup(aws_route_table.private, each.key).id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-rt-public"
  })
}

resource "aws_route_table_association" "public" {
  for_each       = local.zones
  subnet_id      = lookup(aws_subnet.public, each.key).id
  route_table_id = aws_route_table.public.id
}
