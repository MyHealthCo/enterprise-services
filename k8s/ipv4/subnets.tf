resource "aws_subnet" "compute_a" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.usable.vpc_id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(var.cidr_usable, 2, 2, 2, 2)[0]

  tags = {
    Name                                                    = "Compute-A"
    Usage                                                   = "Compute"
    "kubernetes.io/role/internal-elb"                       = "1"
    "kubernetes.io/cluster/${aws_eks_cluster.compute.name}" = "shared"
  }
}

resource "aws_subnet" "compute_b" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.usable.vpc_id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(var.cidr_usable, 2, 2, 2, 2)[1]

  tags = {
    Name                                                    = "Compute-B"
    Usage                                                   = "Compute"
    "kubernetes.io/role/internal-elb"                       = "1"
    "kubernetes.io/cluster/${aws_eks_cluster.compute.name}" = "shared"
  }
}

resource "aws_subnet" "compute_c" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.usable.vpc_id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(var.cidr_usable, 2, 2, 2, 2)[2]

  tags = {
    Name                                                    = "Compute-C"
    Usage                                                   = "Compute"
    "kubernetes.io/role/internal-elb"                       = "1"
    "kubernetes.io/cluster/${aws_eks_cluster.compute.name}" = "shared"
  }
}

resource "aws_subnet" "service_endpoint_a" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint.vpc_id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(var.cidr_service_endpoint, 2, 2, 2, 2)[0]

  tags = {
    Name  = "ServiceEndpoint-A"
    Usage = "ServiceEndpoints"
  }
}

resource "aws_subnet" "service_endpoint_b" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint.vpc_id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(var.cidr_service_endpoint, 2, 2, 2, 2)[1]

  tags = {
    Name  = "ServiceEndpoint-B"
    Usage = "ServiceEndpoints"
  }
}

resource "aws_subnet" "service_endpoint_c" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint.vpc_id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(var.cidr_service_endpoint, 2, 2, 2, 2)[2]

  tags = {
    Name  = "ServiceEndpoint-C"
    Usage = "ServiceEndpoints"
  }
}
