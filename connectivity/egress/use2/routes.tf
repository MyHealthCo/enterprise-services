# Internal Routes
resource "aws_route" "internal_to_inspection_a" {
  provider               = aws.use2
  route_table_id         = aws_route_table.internal_a.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2a"]

  depends_on = [aws_networkfirewall_firewall.egress]
}

resource "aws_route" "internal_to_inspection_b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.internal_b.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2b"]

  depends_on = [aws_networkfirewall_firewall.egress]
}

resource "aws_route" "internal_to_inspection_c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.internal_c.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2c"]

  depends_on = [aws_networkfirewall_firewall.egress]
}

# Inspection Routes
resource "aws_route" "inspection_to_nat_a" {
  provider               = aws.use2
  route_table_id         = aws_route_table.inspection_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_a.id
}

resource "aws_route" "inspection_to_nat_b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.inspection_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_b.id
}

resource "aws_route" "inspection_to_nat_c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.inspection_c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_c.id
}

resource "aws_route" "inspection_return_internal_a" {
  provider               = aws.use2
  route_table_id         = aws_route_table.inspection_a.id
  destination_cidr_block = "10.0.0.0/8"
  core_network_arn       = var.core_network_arn
  depends_on             = [aws_networkmanager_attachment_accepter.accept]
}

resource "aws_route" "inspection_return_internal_b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.inspection_b.id
  destination_cidr_block = "10.0.0.0/8"
  core_network_arn       = var.core_network_arn
  depends_on             = [aws_networkmanager_attachment_accepter.accept]
}

resource "aws_route" "inspection_return_internal_c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.inspection_c.id
  destination_cidr_block = "10.0.0.0/8"
  core_network_arn       = var.core_network_arn
  depends_on             = [aws_networkmanager_attachment_accepter.accept]
}

# Public Routes
resource "aws_route" "public_to_igw_a" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route" "public_to_igw_b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route" "public_to_igw_c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_c.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route" "public_return_to_inspection_a" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_a.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2a"]
}

resource "aws_route" "public_return_to_inspection_b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_b.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2b"]
}

resource "aws_route" "public_return_to_inspection_c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_c.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2c"]
}

resource "aws_route" "public_return_local_a" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_a.id
  destination_cidr_block = aws_subnet.internal_a.cidr_block
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2a"]
}

resource "aws_route" "public_return_local_b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_b.id
  destination_cidr_block = aws_subnet.internal_b.cidr_block
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2b"]
}

resource "aws_route" "public_return_local_c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_c
  destination_cidr_block = aws_subnet.internal_c.cidr_block
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2c"]
}
