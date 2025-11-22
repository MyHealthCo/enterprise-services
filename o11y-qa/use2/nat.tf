# EIP and NAT Gateways
resource "aws_eip" "nat_use2a" {
  provider         = aws.use2
  domain           = "vpc"
  public_ipv4_pool = "amazon"

  tags = {
    Name = "o11y-qa-nat-eip-use2a"
  }
}

resource "aws_eip" "nat_use2b" {
  provider         = aws.use2
  domain           = "vpc"
  public_ipv4_pool = "amazon"

  tags = {
    Name = "o11y-qa-nat-eip-use2b"
  }
}

resource "aws_eip" "nat_use2c" {
  provider         = aws.use2
  domain           = "vpc"
  public_ipv4_pool = "amazon"

  tags = {
    Name = "o11y-qa-nat-eip-use2c"
  }
}

resource "aws_nat_gateway" "nat_use2a" {
  provider          = aws.use2
  allocation_id     = aws_eip.nat_use2a.id
  subnet_id         = aws_subnet.public_use2a.id
  connectivity_type = "public"

  tags = {
    Name = "o11y-qa-nat-use2a"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_use2b" {
  provider          = aws.use2
  allocation_id     = aws_eip.nat_use2b.id
  subnet_id         = aws_subnet.public_use2b.id
  connectivity_type = "public"

  tags = {
    Name = "o11y-qa-nat-use2b"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_use2c" {
  provider          = aws.use2
  allocation_id     = aws_eip.nat_use2c.id
  subnet_id         = aws_subnet.public_use2c.id
  connectivity_type = "public"

  tags = {
    Name = "o11y-qa-nat-use2c"
  }

  depends_on = [aws_internet_gateway.igw]
}
