resource "aws_internet_gateway" "main" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "egress"
  }
}
