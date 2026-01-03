resource "aws_network_acl" "standard" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Standard-Network-ACL"
  }
}

resource "aws_network_acl_association" "compute_a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "compute_b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "compute_c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_c.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "compute_native_a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_native_a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "compute_native_b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_native_b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "compute_native_c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_native_c.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_endpoint_a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_endpoint_b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_endpoint_c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_c.id
  network_acl_id = aws_network_acl.standard.id
}
