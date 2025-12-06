resource "aws_subnet" "internal_a" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[0]

  tags = {
    Name  = "internal-a"
    Usage = "Internal"
  }
}

resource "aws_subnet" "internal_b" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[1]

  tags = {
    Name    = "internal-b"
    Purpose = "Internal"
  }
}

resource "aws_subnet" "internal_c" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[2]

  tags = {
    Name    = "internal-c"
    Purpose = "Internal"
  }
}
