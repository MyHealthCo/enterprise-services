resource "aws_vpc" "main" {
  provider             = aws.use2
  cidr_block           = var.cidr_primary
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "consumer"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "usable_cidr" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_usable
}
