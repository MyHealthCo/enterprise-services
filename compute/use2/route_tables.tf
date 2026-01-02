# Internal Route Tables
resource "aws_route_table" "internal_a" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "internal-a"
  }
}

resource "aws_route_table" "internal_b" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "internal-b"
  }
}

resource "aws_route_table" "internal_c" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "internal-c"
  }
}

# Route Table Associations
resource "aws_route_table_association" "internal_a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.internal_a.id
  route_table_id = aws_route_table.internal_a.id
}

resource "aws_route_table_association" "internal_b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.internal_b.id
  route_table_id = aws_route_table.internal_b.id
}

resource "aws_route_table_association" "internal_c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.internal_c.id
  route_table_id = aws_route_table.internal_c.id
}

resource "aws_route_table_association" "service_endpoint_a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_a.id
  route_table_id = aws_route_table.internal_a.id
}

resource "aws_route_table_association" "service_endpoint_b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_b.id
  route_table_id = aws_route_table.internal_b.id
}

resource "aws_route_table_association" "service_endpoint_c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_c.id
  route_table_id = aws_route_table.internal_c.id
}
