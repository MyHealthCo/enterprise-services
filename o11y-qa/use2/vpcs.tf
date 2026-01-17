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

resource "aws_vpc_ipv4_cidr_block_association" "public_cidr_range" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidr_range
}

output "vpc_id" {
  value = aws_vpc.main.id
}
