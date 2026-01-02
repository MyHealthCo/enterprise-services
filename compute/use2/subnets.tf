# Internal Subnets
resource "aws_subnet" "internal_a" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.internal.vpc_id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(var.cidr_internal, 2, 2, 2)[0]

  tags = {
    Name  = "compute-internal-a"
    Usage = "Internal"
  }
}

resource "aws_subnet" "internal_b" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.internal.vpc_id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(var.cidr_internal, 2, 2, 2)[1]

  tags = {
    Name  = "compute-internal-b"
    Usage = "Internal"
  }
}

resource "aws_subnet" "internal_c" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.internal.vpc_id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(var.cidr_internal, 2, 2, 2)[2]

  tags = {
    Name  = "compute-internal-c"
    Usage = "Internal"
  }
}

# Service Endpoint Subnets
resource "aws_subnet" "service_endpoint_a" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint.vpc_id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(var.cidr_service_endpoint, 2, 2, 2)[0]

  tags = {
    Name  = "compute-service-endpoint-a"
    Usage = "ServiceEndpoints"
  }
}

resource "aws_subnet" "service_endpoint_b" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint.vpc_id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(var.cidr_service_endpoint, 2, 2, 2)[1]

  tags = {
    Name  = "compute-service-endpoint-b"
    Usage = "ServiceEndpoints"
  }
}

resource "aws_subnet" "service_endpoint_c" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint.vpc_id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(var.cidr_service_endpoint, 2, 2, 2)[2]

  tags = {
    Name  = "compute-service-endpoint-c"
    Usage = "ServiceEndpoints"
  }
}
