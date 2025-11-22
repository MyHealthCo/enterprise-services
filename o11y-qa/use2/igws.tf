# Internet Gateway
resource "aws_internet_gateway" "igw" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "o11y-qa-igw"
  }
}
