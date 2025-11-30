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

resource "aws_route_table" "inspection_a" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "inspection-a"
  }
}

resource "aws_route_table" "inspection_b" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "inspection-b"
  }
}

resource "aws_route_table" "inspection_c" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "inspection-c"
  }
}

resource "aws_route_table" "public_a" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "public-a"
  }
}

resource "aws_route_table" "public_b" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "public-b"
  }
}

resource "aws_route_table" "public_c" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "public-c"
  }
}

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

resource "aws_route_table_association" "inspection_a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_a.id
  route_table_id = aws_route_table.inspection_a.id
}

resource "aws_route_table_association" "inspection_b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_b.id
  route_table_id = aws_route_table.inspection_b.id
}


resource "aws_route_table_association" "inspection_c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_c.id
  route_table_id = aws_route_table.inspection_c.id
}

resource "aws_route_table_association" "public_a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_a.id
}

resource "aws_route_table_association" "public_b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_b.id
}


resource "aws_route_table_association" "public_c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public_c.id
}
