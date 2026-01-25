resource "aws_route_table" "internal" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "internal"
  }
}

resource "aws_route_table_association" "internal_a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.internal_a.id
  route_table_id = aws_route_table.internal.id
}

resource "aws_route_table_association" "internal_b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.internal_b.id
  route_table_id = aws_route_table.internal.id
}

resource "aws_route_table_association" "internal_c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.internal_c.id
  route_table_id = aws_route_table.internal.id
}
