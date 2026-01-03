resource "aws_vpc" "main" {
  provider             = aws.use2
  cidr_block           = var.cidr_primary
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "k8s-ipv6"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "usable" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_usable
}

resource "aws_vpc_ipv4_cidr_block_association" "service_endpoint" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_service_endpoint
}

resource "aws_vpc_ipv6_cidr_block_association" "main" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  assign_generated_ipv6_cidr_block = true
}
