resource "aws_route_table" "compute" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "Compute-RouteTable"
  }
}

resource "aws_route_table" "service_endpoint" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "ServiceEndpoint-RouteTable"
  }
}

resource "aws_route_table_association" "compute_a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_a.id
  route_table_id = aws_route_table.compute.id
}

resource "aws_route_table_association" "compute_b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_b.id
  route_table_id = aws_route_table.compute.id
}

resource "aws_route_table_association" "compute_c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_c.id
  route_table_id = aws_route_table.compute.id
}

resource "aws_route_table_association" "service_endpoint_a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_a.id
  route_table_id = aws_route_table.service_endpoint.id
}

resource "aws_route_table_association" "service_endpoint_b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_b.id
  route_table_id = aws_route_table.service_endpoint.id
}

resource "aws_route_table_association" "service_endpoint_c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_c.id
  route_table_id = aws_route_table.service_endpoint.id
}
