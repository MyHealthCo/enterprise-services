## Private Routes
resource "aws_route" "private_to_firewall_use2a" {
  provider               = aws.use2
  route_table_id         = aws_route_table.private_use2a.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2a"]
}

resource "aws_route" "private_to_firewall_use2b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.private_use2b.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2b"]
}

resource "aws_route" "private_to_firewall_use2c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.private_use2c.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2c"]
}

## Inspection Routes
resource "aws_route" "inspection_to_nat_use2a" {
  provider               = aws.use2
  route_table_id         = aws_route_table.inspection_use2a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_use2a.id
}

resource "aws_route" "inspection_to_nat_use2b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.inspection_use2b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_use2b.id
}

resource "aws_route" "inspection_to_nat_use2c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.inspection_use2c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_use2c.id
}

## NAT Routes
resource "aws_route" "nat_to_internet_use2a" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_use2a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "nat_to_internet_use2b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_use2b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "nat_to_internet_use2c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_use2c.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "nat_return_inspection_use2a" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_use2a.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2a"]
}

resource "aws_route" "nat_return_inspection_use2b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_use2b.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2b"]
}

resource "aws_route" "nat_return_inspection_use2c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_use2c.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2c"]
}
