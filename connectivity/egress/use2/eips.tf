resource "aws_eip" "nat_a" {
  provider         = aws.use2
  domain           = "vpc"
  public_ipv4_pool = "amazon"

  tags = {
    Name = "NAT-Gateway-A"
  }
}

resource "aws_eip" "nat_b" {
  provider         = aws.use2
  domain           = "vpc"
  public_ipv4_pool = "amazon"

  tags = {
    Name = "NAT-Gateway-B"
  }
}

resource "aws_eip" "nat_c" {
  provider         = aws.use2
  domain           = "vpc"
  public_ipv4_pool = "amazon"

  tags = {
    Name = "NAT-Gateway-C"
  }
}
