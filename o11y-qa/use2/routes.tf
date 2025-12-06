## Private Routes
resource "aws_route" "private_to_firewall_use2a" {
  provider               = aws.use2
  route_table_id         = aws_route_table.private_use2a.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2a"]

  depends_on = [aws_networkfirewall_firewall.o11y_qa]
}

resource "aws_route" "private_to_firewall_use2b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.private_use2b.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2b"]

  depends_on = [aws_networkfirewall_firewall.o11y_qa]
}

resource "aws_route" "private_to_firewall_use2c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.private_use2c.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2c"]

  depends_on = [aws_networkfirewall_firewall.o11y_qa]
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

  depends_on = [aws_networkfirewall_firewall.o11y_qa]
}

resource "aws_route" "nat_return_inspection_use2b" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_use2b.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2b"]

  depends_on = [aws_networkfirewall_firewall.o11y_qa]
}

resource "aws_route" "nat_return_inspection_use2c" {
  provider               = aws.use2
  route_table_id         = aws_route_table.public_use2c.id
  destination_cidr_block = "10.0.0.0/8"
  vpc_endpoint_id        = local.firewall_endpoints["us-east-2c"]

  depends_on = [aws_networkfirewall_firewall.o11y_qa]
}

resource "aws_route" "public_return_local_a" {
    provider = aws.use2
    route_table_id = aws_route_table.public_use2a.id
    destination_cidr_block = aws_subnet.public_use2a.cidr_block
    vpc_endpoint_id = local.firewall_endpoints["us-east-2a"]
}

resource "aws_route" "public_return_local_b" {
    provider = aws.use2
    route_table_id = aws_route_table.public_use2b.id
    destination_cidr_block = aws_subnet.public_use2b.cidr_block
    vpc_endpoint_id = local.firewall_endpoints["us-east-2b"]
}

resource "aws_route" "public_return_local_c" {
    provider = aws.use2
    route_table_id = aws_route_table.public_use2c.id
    destination_cidr_block = aws_subnet.public_use2c.cidr_block
    vpc_endpoint_id = local.firewall_endpoints["us-east-2c"]
}
