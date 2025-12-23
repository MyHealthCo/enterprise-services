resource "aws_subnet" "compute_a" {
  provider = aws.use2
  vpc_id   = aws_vpc_ipv4_cidr_block_association.usable.vpc_id

  assign_ipv6_address_on_creation = true
  availability_zone               = "us-east-2a"
  cidr_block                      = cidrsubnets(var.cidr_usable, 2, 2, 2, 2)[0]
  enable_dns64                    = true

  tags = {
    Name  = "Compute-A"
    Usage = "Compute"
  }

  depends_on = [aws_vpc_ipv6_cidr_block_association.main]
}

resource "aws_subnet" "compute_b" {
  provider = aws.use2
  vpc_id   = aws_vpc_ipv4_cidr_block_association.usable.vpc_id

  assign_ipv6_address_on_creation = true
  availability_zone               = "us-east-2b"
  cidr_block                      = cidrsubnets(var.cidr_usable, 2, 2, 2, 2)[1]
  enable_dns64                    = true

  tags = {
    Name  = "Compute-B"
    Usage = "Compute"
  }

  depends_on = [aws_vpc_ipv6_cidr_block_association.main]
}

resource "aws_subnet" "compute_c" {
  provider = aws.use2
  vpc_id   = aws_vpc_ipv4_cidr_block_association.usable.vpc_id

  assign_ipv6_address_on_creation = true
  availability_zone               = "us-east-2c"
  cidr_block                      = cidrsubnets(var.cidr_usable, 2, 2, 2, 2)[2]
  enable_dns64                    = true

  tags = {
    Name  = "Compute-C"
    Usage = "Compute"
  }

  depends_on = [aws_vpc_ipv6_cidr_block_association.main]
}

resource "aws_subnet" "compute_native_a" {
  provider = aws.use2
  vpc_id   = aws_vpc_ipv6_cidr_block_association.main.vpc_id

  assign_ipv6_address_on_creation = true
  availability_zone               = "us-east-2a"
  ipv6_native                     = true

  tags = {
    Name  = "Compute-Native-A"
    Usage = "Compute"
  }
}

resource "aws_subnet" "compute_native_b" {
  provider = aws.use2
  vpc_id   = aws_vpc_ipv6_cidr_block_association.main.vpc_id

  assign_ipv6_address_on_creation = true
  availability_zone               = "us-east-2b"
  ipv6_native                     = true

  tags = {
    Name  = "Compute-Native-B"
    Usage = "Compute"
  }
}

resource "aws_subnet" "compute_native_c" {
  provider = aws.use2
  vpc_id   = aws_vpc_ipv6_cidr_block_association.main.vpc_id

  assign_ipv6_address_on_creation = true
  availability_zone               = "us-east-2c"
  ipv6_native                     = true

  tags = {
    Name  = "Compute-Native-C"
    Usage = "Compute"
  }
}

resource "aws_subnet" "service_endpoint_a" {
  provider = aws.use2
  vpc_id   = aws_vpc_ipv4_cidr_block_association.service_endpoint.vpc_id

  assign_ipv6_address_on_creation = true
  availability_zone               = "us-east-2a"
  cidr_block                      = cidrsubnets(var.cidr_service_endpoint, 2, 2, 2, 2)[0]
  enable_dns64                    = true

  tags = {
    Name  = "ServiceEndpoint-A"
    Usage = "ServiceEndpoints"
  }
}

resource "aws_subnet" "service_endpoint_b" {
  provider = aws.use2
  vpc_id   = aws_vpc_ipv4_cidr_block_association.service_endpoint.vpc_id

  assign_ipv6_address_on_creation = true
  availability_zone               = "us-east-2b"
  cidr_block                      = cidrsubnets(var.cidr_service_endpoint, 2, 2, 2, 2)[1]
  enable_dns64                    = true

  tags = {
    Name  = "ServiceEndpoint-B"
    Usage = "ServiceEndpoints"
  }
}

resource "aws_subnet" "service_endpoint_c" {
  provider = aws.use2
  vpc_id   = aws_vpc_ipv4_cidr_block_association.service_endpoint.vpc_id

  assign_ipv6_address_on_creation = true
  availability_zone               = "us-east-2c"
  cidr_block                      = cidrsubnets(var.cidr_service_endpoint, 2, 2, 2, 2)[2]
  enable_dns64                    = true

  tags = {
    Name  = "ServiceEndpoint-C"
    Usage = "ServiceEndpoints"
  }
}
