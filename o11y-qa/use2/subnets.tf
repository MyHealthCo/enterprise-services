# Subnets
## lb
resource "aws_subnet" "lb_use2a" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.lb_cidr_range.vpc_id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(var.lb_cidr_range, 2, 2, 2, 2)[0]

  tags = {
    Name  = "o11y-qa-lb-az2a"
    Usage = "LoadBalancers"
  }
}

resource "aws_subnet" "lb_use2b" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.lb_cidr_range.vpc_id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(var.lb_cidr_range, 2, 2, 2, 2)[1]

  tags = {
    Name  = "o11y-qa-lb-az2b"
    Usage = "LoadBalancers"
  }
}

resource "aws_subnet" "lb_use2c" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.lb_cidr_range.vpc_id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(var.lb_cidr_range, 2, 2, 2, 2)[2]

  tags = {
    Name  = "o11y-qa-lb-az2c"
    Usage = "LoadBalancers"
  }
}

## Service Provider
resource "aws_subnet" "service_provider_use2_az1" {
  provider             = aws.use2
  vpc_id               = aws_vpc_ipv4_cidr_block_association.service_provider_cidr_range.vpc_id
  availability_zone_id = "use2-az1"
  cidr_block           = cidrsubnets(var.service_provider_cidr_range, 2, 2, 2, 2)[0]

  tags = {
    Name  = "o11y-qa-provider-use2-az1"
    Usage = "ServiceProviders"
  }
}

resource "aws_subnet" "service_provider_use2_az2" {
  provider             = aws.use2
  vpc_id               = aws_vpc_ipv4_cidr_block_association.service_provider_cidr_range.vpc_id
  availability_zone_id = "use2-az2"
  cidr_block           = cidrsubnets(var.service_provider_cidr_range, 2, 2, 2, 2)[1]

  tags = {
    Name  = "o11y-qa-provider-use2-az2"
    Usage = "ServiceProviders"
  }
}

resource "aws_subnet" "service_provider_use2_az3" {
  provider             = aws.use2
  vpc_id               = aws_vpc_ipv4_cidr_block_association.service_provider_cidr_range.vpc_id
  availability_zone_id = "use2-az3"
  cidr_block           = cidrsubnets(var.service_provider_cidr_range, 2, 2, 2, 2)[2]

  tags = {
    Name  = "o11y-qa-provider-use2-az3"
    Usage = "ServiceProviders"
  }
}

## Service Endpoint
resource "aws_subnet" "service_endpoint_use2a" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint_cidr_range.vpc_id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(var.service_endpoint_cidr_range, 2, 2, 2, 2)[0]

  tags = {
    Name  = "o11y-qa-service-endpoint-az2a"
    Usage = "ServiceEndpoints"
  }
}

resource "aws_subnet" "service_endpoint_use2b" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint_cidr_range.vpc_id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(var.service_endpoint_cidr_range, 2, 2, 2, 2)[1]

  tags = {
    Name  = "o11y-qa-service-endpoint-az2b"
    Usage = "ServiceEndpoints"
  }
}

resource "aws_subnet" "service_endpoint_use2c" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint_cidr_range.vpc_id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(var.service_endpoint_cidr_range, 2, 2, 2, 2)[2]

  tags = {
    Name  = "o11y-qa-service-endpoint-az2c"
    Usage = "ServiceEndpoints"
  }
}

## Compute
resource "aws_subnet" "compute_use2a" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.compute_cidr_range.vpc_id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(var.compute_cidr_range, 2, 2, 2, 2)[0]

  tags = {
    Name  = "o11y-qa-compute-az2a"
    Usage = "Processing"
  }
}

resource "aws_subnet" "compute_use2b" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.compute_cidr_range.vpc_id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(var.compute_cidr_range, 2, 2, 2, 2)[1]

  tags = {
    Name  = "o11y-qa-compute-az2b"
    Usage = "Processing"
  }
}

resource "aws_subnet" "compute_use2c" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.compute_cidr_range.vpc_id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(var.compute_cidr_range, 2, 2, 2, 2)[2]

  tags = {
    Name  = "o11y-qa-compute-az2c"
    Usage = "Processing"
  }
}

## Inspection
resource "aws_subnet" "inspection_use2a" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.inspection_cidr_range.vpc_id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(var.inspection_cidr_range, 2, 2, 2, 2)[0]

  tags = {
    Name  = "o11y-qa-inspection-az2a"
    Usage = "Inspection"
  }
}

resource "aws_subnet" "inspection_use2b" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.inspection_cidr_range.vpc_id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(var.inspection_cidr_range, 2, 2, 2, 2)[1]

  tags = {
    Name  = "o11y-qa-inspection-az2b"
    Usage = "Inspection"
  }
}

resource "aws_subnet" "inspection_use2c" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.inspection_cidr_range.vpc_id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(var.inspection_cidr_range, 2, 2, 2, 2)[2]

  tags = {
    Name  = "o11y-qa-inspection-az2c"
    Usage = "Inspection"
  }
}

## Public NAT
resource "aws_subnet" "public_use2a" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.public_cidr_range.vpc_id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(var.public_cidr_range, 2, 2, 2, 2)[0]

  tags = {
    Name  = "o11y-qa-public-nat-az2a"
    Usage = "PublicNAT"
  }
}

resource "aws_subnet" "public_use2b" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.public_cidr_range.vpc_id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(var.public_cidr_range, 2, 2, 2, 2)[1]

  tags = {
    Name  = "o11y-qa-public-nat-az2b"
    Usage = "PublicNAT"
  }
}

resource "aws_subnet" "public_use2c" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.public_cidr_range.vpc_id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(var.public_cidr_range, 2, 2, 2, 2)[2]

  tags = {
    Name  = "o11y-qa-public-nat-az2c"
    Usage = "PublicNAT"
  }
}
