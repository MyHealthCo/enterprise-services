# Route Tables
## Private Route Tables
resource "aws_route_table" "private_use2a" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "private-use2a-route-table"
  }
}

resource "aws_route_table" "private_use2b" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "private-use2b-route-table"
  }
}

resource "aws_route_table" "private_use2c" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "private-use2c-route-table"
  }
}

## Inspection Route Tables
resource "aws_route_table" "inspection_use2a" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "inspection-use2a-route-table"
  }
}

resource "aws_route_table" "inspection_use2b" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "inspection-use2b-route-table"
  }
}

resource "aws_route_table" "inspection_use2c" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "inspection-use2c-route-table"
  }
}

## NAT Route Tables
resource "aws_route_table" "public_use2a" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "public-use2a-route-table"
  }
}

resource "aws_route_table" "public_use2b" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "public-use2b-route-table"
  }
}

resource "aws_route_table" "public_use2c" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "public-use2c-route-table"
  }
}

# Route Table Associations
resource "aws_route_table_association" "lb_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.lb_use2a.id
  route_table_id = aws_route_table.private_use2a.id
}

resource "aws_route_table_association" "lb_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.lb_use2b.id
  route_table_id = aws_route_table.private_use2b.id
}

resource "aws_route_table_association" "lb_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.lb_use2c.id
  route_table_id = aws_route_table.private_use2c.id
}

resource "aws_route_table_association" "compute_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_use2a.id
  route_table_id = aws_route_table.private_use2a.id
}

resource "aws_route_table_association" "compute_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_use2b.id
  route_table_id = aws_route_table.private_use2b.id
}

resource "aws_route_table_association" "compute_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_use2c.id
  route_table_id = aws_route_table.private_use2c.id
}

resource "aws_route_table_association" "service_endpoint_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_use2a.id
  route_table_id = aws_route_table.private_use2a.id
}

resource "aws_route_table_association" "service_endpoint_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_use2b.id
  route_table_id = aws_route_table.private_use2b.id
}

resource "aws_route_table_association" "service_endpoint_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_use2c.id
  route_table_id = aws_route_table.private_use2c.id
}

resource "aws_route_table_association" "service_provider_use2_az1" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_provider_use2_az1.id
  route_table_id = aws_route_table.private_use2a.id
}

resource "aws_route_table_association" "service_provider_use2_az2" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_provider_use2_az2.id
  route_table_id = aws_route_table.private_use2b.id
}

resource "aws_route_table_association" "service_provider_use2_az3" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_provider_use2_az3.id
  route_table_id = aws_route_table.private_use2c.id
}

resource "aws_route_table_association" "inspection_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_use2a.id
  route_table_id = aws_route_table.inspection_use2a.id
}

resource "aws_route_table_association" "inspection_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_use2b.id
  route_table_id = aws_route_table.inspection_use2b.id
}

resource "aws_route_table_association" "inspection_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_use2c.id
  route_table_id = aws_route_table.inspection_use2c.id
}

resource "aws_route_table_association" "nat_egress_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_use2a.id
  route_table_id = aws_route_table.public_use2a.id
}

resource "aws_route_table_association" "nat_egress_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_use2b.id
  route_table_id = aws_route_table.public_use2b.id
}

resource "aws_route_table_association" "nat_egress_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_use2c.id
  route_table_id = aws_route_table.public_use2c.id
}
