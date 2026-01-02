variable "cidr_internal" {
  description = "Internal CIDR range for compute workloads"
  type        = string
  default     = "10.2.10.0/23"
}

resource "aws_vpc" "main" {
  provider             = aws.use2
  cidr_block           = var.cidr_primary
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "compute"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "internal" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_internal
}

resource "aws_vpc_ipv4_cidr_block_association" "service_endpoint" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_service_endpoint
}
