resource "aws_security_group" "tester" {
  provider = aws.use2
  name     = "Tester-SG"
  vpc_id   = aws_vpc.main.id

  tags = {
    Name    = "Tester-SG"
    Purpose = "Test Egress Connectivity"
  }
}
