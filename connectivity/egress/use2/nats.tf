resource "aws_nat_gateway" "nat_a" {
  provider          = aws.use2
  allocation_id     = aws_eip.nat_a.id
  subnet_id         = aws_subnet.public_a.id
  connectivity_type = "public"

  tags = {
    Name = "NAT-A"
  }
}

resource "aws_nat_gateway" "nat_b" {
  provider          = aws.use2
  allocation_id     = aws_eip.nat_b.id
  subnet_id         = aws_subnet.public_b.id
  connectivity_type = "public"

  tags = {
    Name = "NAT-B"
  }
}

resource "aws_nat_gateway" "nat_c" {
  provider          = aws.use2
  allocation_id     = aws_eip.nat_c.id
  subnet_id         = aws_subnet.public_c.id
  connectivity_type = "public"

  tags = {
    Name = "NAT-C"
  }
}
