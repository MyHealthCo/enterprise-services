locals {
  azs = ["a", "b", "c"]
}

resource "aws_subnet" "internal_a" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[0], 2, 2, 2)[0]

  tags = {
    Name    = "internal-a"
    Purpose = "Internal"
  }
}

resource "aws_subnet" "internal_b" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[0], 2, 2, 2)[1]

  tags = {
    Name    = "internal-b"
    Purpose = "Internal"
  }
}

resource "aws_subnet" "internal_c" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[0], 2, 2, 2)[2]

  tags = {
    Name    = "internal-c"
    Purpose = "Internal"
  }
}

resource "aws_subnet" "inspection_a" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[1], 2, 2, 2)[0]

  tags = {
    Name    = "inspection-a"
    Purpose = "Inspection"
  }
}

resource "aws_subnet" "inspection_b" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[1], 2, 2, 2)[1]

  tags = {
    Name    = "inspection-b"
    Purpose = "Inspection"
  }
}

resource "aws_subnet" "inspection_c" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[1], 2, 2, 2)[2]

  tags = {
    Name    = "inspection-c"
    Purpose = "Inspection"
  }
}

resource "aws_subnet" "public_a" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[2], 2, 2, 2)[0]

  tags = {
    Name    = "public-a"
    Purpose = "Public-NAT"
  }
}

resource "aws_subnet" "public_b" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[2], 2, 2, 2)[1]

  tags = {
    Name    = "public-b"
    Purpose = "Public-NAT"
  }
}

resource "aws_subnet" "public_c" {
  provider          = aws.use2
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[2], 2, 2, 2)[2]

  tags = {
    Name    = "public-c"
    Purpose = "Public-NAT"
  }
}
