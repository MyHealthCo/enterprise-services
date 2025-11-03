# MyHealthCo-o11y-qa

# CIDR Ranges
variable "lb_cidr_range" {
  type    = string
  default = "10.1.0.0/24"
}

variable "service_provider_cidr_range" {
  type    = string
  default = "10.100.32.0/19"
}

variable "service_endpoint_cidr_range" {
  type    = string
  default = "10.100.64.0/19"
}

variable "compute_cidr_range" {
  type    = string
  default = "10.1.4.0/22"
}

variable "inspection_cidr_range" {
  type    = string
  default = "10.1.1.0/26"
}

variable "public_nat_cidr_range" {
  type    = string
  default = "10.1.1.64/26"
}

# VPC
resource "aws_vpc" "main" {
  provider             = aws.use2
  cidr_block           = "10.0.0.0/28"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "o11y-qa"
  }
}

# VPC CIDR Block Associations
resource "aws_vpc_ipv4_cidr_block_association" "lb_cidr_range" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.lb_cidr_range
}

resource "aws_vpc_ipv4_cidr_block_association" "service_provider_cidr_range" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.service_provider_cidr_range
}

resource "aws_vpc_ipv4_cidr_block_association" "service_endpoint_cidr_range" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.service_endpoint_cidr_range
}

resource "aws_vpc_ipv4_cidr_block_association" "compute_cidr_range" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.compute_cidr_range
}

resource "aws_vpc_ipv4_cidr_block_association" "inspection_cidr_range" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.inspection_cidr_range
}

resource "aws_vpc_ipv4_cidr_block_association" "public_nat_cidr_range" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_nat_cidr_range
}

# nACLs
resource "aws_network_acl" "standard" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  egress {
    rule_no     = 1000
    protocol    = "-1"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 0
    to_port     = 0
  }

  ingress {
    rule_number = 1000
    protocol    = "-1"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "Standard NACL"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "o11y-qa-igw"
  }
}

resource "aws_internet_gateway_attachment" "igw_attachment" {
  provider            = aws.use2
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id              = aws_vpc.main.id
}

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

resource "aws_subnet" "service_provider_use2_az1" {
  provider             = aws.use2
  vpc_id               = aws_vpc_ipv4_cidr_block_association.service_provider_cidr_range.vpc_id
  availability_zone_id = "use2-az1"
  cidr_block           = cidrsubnets(var.service_provider_cidr_range, 2, 2, 2, 2)[0]

  tags = {
    Name  = "o11y-qa-provider-use2-az1"
    Usage = "ServiceProvider"
  }
}

resource "aws_subnet" "service_provider_use2_az2" {
  provider             = aws.use2
  vpc_id               = aws_vpc_ipv4_cidr_block_association.service_provider_cidr_range.vpc_id
  availability_zone_id = "use2-az2"
  cidr_block           = cidrsubnets(var.service_provider_cidr_range, 2, 2, 2, 2)[1]

  tags = {
    Name  = "o11y-qa-provider-use2-az2"
    Usage = "ServiceProvider"
  }
}

resource "aws_subnet" "service_provider_use2_az3" {
  provider             = aws.use2
  vpc_id               = aws_vpc_ipv4_cidr_block_association.service_provider_cidr_range.vpc_id
  availability_zone_id = "use2-az3"
  cidr_block           = cidrsubnets(var.service_provider_cidr_range, 2, 2, 2, 2)[2]

  tags = {
    Name  = "o11y-qa-provider-use2-az3"
    Usage = "ServiceProvider"
  }
}

resource "aws_subnet" "service_endpoint_use2a" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint_cidr_range.vpc_id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(var.compute_cidr_range, 2, 2, 2, 2)[0]

  tags = {
    Name  = "o11y-qa-service-endpoint-az2a"
    Usage = "ServiceEndpoint"
  }
}

resource "aws_subnet" "service_endpoint_use2b" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint_cidr_range.vpc_id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(var.compute_cidr_range, 2, 2, 2, 2)[1]

  tags = {
    Name  = "o11y-qa-service-endpoint-az2b"
    Usage = "ServiceEndpoint"
  }
}

resource "aws_subnet" "service_endpoint_use2c" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.service_endpoint_cidr_range.vpc_id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(var.compute_cidr_range, 2, 2, 2, 2)[2]

  tags = {
    Name  = "o11y-qa-service-endpoint-az2c"
    Usage = "ServiceEndpoint"
  }
}

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

resource "aws_subnet" "public_nat_use2a" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.public_nat_cidr_range.vpc_id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnets(var.public_nat_cidr_range, 2, 2, 2, 2)[0]

  tags = {
    Name  = "o11y-qa-public-nat-az2a"
    Usage = "PublicNAT"
  }
}

resource "aws_subnet" "public_nat_use2b" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.public_nat_cidr_range.vpc_id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnets(var.public_nat_cidr_range, 2, 2, 2, 2)[1]

  tags = {
    Name  = "o11y-qa-public-nat-az2b"
    Usage = "PublicNAT"
  }
}

resource "aws_subnet" "public_nat_use2c" {
  provider          = aws.use2
  vpc_id            = aws_vpc_ipv4_cidr_block_association.public_nat_cidr_range.vpc_id
  availability_zone = "us-east-2c"
  cidr_block        = cidrsubnets(var.public_nat_cidr_range, 2, 2, 2, 2)[2]

  tags = {
    Name  = "o11y-qa-public-nat-az2c"
    Usage = "PublicNAT"
  }
}

# EIP and NAT Gateways

resource "aws_eip" "nat_use2a" {
  provider         = aws.use2
  vpc              = true
  public_ipv4_pool = "amazon"

  tags = {
    Name = "o11y-qa-nat-eip-use2a"
  }
}

resource "aws_eip" "nat_use2b" {
  provider         = aws.use2
  vpc              = true
  public_ipv4_pool = "amazon"

  tags = {
    Name = "o11y-qa-nat-eip-use2b"
  }
}

resource "aws_eip" "nat_use2c" {
  provider         = aws.use2
  vpc              = true
  public_ipv4_pool = "amazon"

  tags = {
    Name = "o11y-qa-nat-eip-use2c"
  }
}

resource "aws_nat_gateway" "nat_use2a" {
  provider          = aws.use2
  allocation_id     = aws_eip.nat_use2a.id
  subnet_id         = aws_subnet.public_nat_use2a.id
  connectivity_type = "public"

  tags = {
    Name = "o11y-qa-nat-use2a"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_egress_use2b" {
  provider          = aws.use2
  allocation_id     = aws_eip.nat_use2b.id
  subnet_id         = aws_subnet.public_nat_use2b.id
  connectivity_type = "public"

  tags = {
    Name = "o11y-qa-nat-use2b"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_egress_use2c" {
  provider          = aws.use2
  allocation_id     = aws_eip.nat_use2c.id
  subnet_id         = aws_subnet.public_nat_use2c.id
  connectivity_type = "public"

  tags = {
    Name = "o11y-qa-nat-use2c"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Route Tables

resource "aws_route_table" "public_nat" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block = var.inspection_cidr_range
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_egress_use2a.id
  }

  tags = {
    Name = "o11y-qa-public-nat-route-table"
  }
}

resource "aws_route_table" "public_egress" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block = var.public_nat_cidr_range
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "o11y-qa-public-egress-route-table"
  }
}

# Route Table Associations
resource "aws_route_table_association" "nat_egress_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_nat_use2a.id
  route_table_id = aws_route_table.public_nat_egress.id

}

resource "aws_route_table_association" "nat_egress_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_nat_use2b.id
  route_table_id = aws_route_table.public_nat_egress.id

}

resource "aws_route_table_association" "nat_egress_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_nat_use2c.id
  route_table_id = aws_route_table.public_nat_egress.id

}

# nACL Associations
resource "aws_network_acl_association" "lb_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.lb_use2a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "lb_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.lb_use2b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "lb_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.lb_use2c.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_provider_use2_az1" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_provider_use2_az1.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_provider_use2_az2" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_provider_use2_az2.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_provider_use2_az3" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_provider_use2_az3.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_endpoint_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_use2a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_endpoint_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_use2b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_endpoint_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_use2c.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "compute_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_use2a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "compute_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_use2b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "compute_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_use2c.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "inspection_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_use2a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "inspection_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_use2b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "inspection_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_use2c.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "public_nat_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_nat_use2a.id
  network_ack_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "public_nat_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_nat_use2b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "public_nat_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_nat_use2c.id
  network_acl_id = aws_network_acl.standard.id
}
