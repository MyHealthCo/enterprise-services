resource "aws_security_group" "tester" {
  provider = aws.use2
  name     = "Tester-SG"
  vpc_id   = aws_vpc.main.id

  tags = {
    Name    = "Tester-SG"
    Purpose = "Test Egress Connectivity"
  }
}

resource "aws_security_group_rule" "tester_ingress_http" {
  provider          = aws.use2
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "tcp"
  security_group_id = aws_security_group.tester.id
  cidr_blocks       = ["0.0.0.0/0"]
}
