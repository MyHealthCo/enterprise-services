# nACLs
resource "aws_network_acl" "standard" {
  provider = aws.use2
  vpc_id   = aws_vpc.main.id

  egress {
    rule_no    = 1000
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    rule_no    = 1000
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Standard NACL"
  }
}

# nACL Associations
resource "aws_network_acl_association" "lb_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.lb_use2a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "lb_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.lb_use2b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "lb_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.lb_use2c.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_provider_use2_az1" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_provider_use2_az1.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_provider_use2_az2" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_provider_use2_az2.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_provider_use2_az3" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_provider_use2_az3.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_endpoint_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_use2a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_endpoint_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_use2b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "service_endpoint_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.service_endpoint_use2c.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "compute_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_use2a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "compute_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_use2b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "compute_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.compute_use2c.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "inspection_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_use2a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "inspection_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_use2b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "inspection_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.inspection_use2c.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "public_nat_use2a" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_use2a.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "public_nat_use2b" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_use2b.id
  network_acl_id = aws_network_acl.standard.id
}

resource "aws_network_acl_association" "public_nat_use2c" {
  provider       = aws.use2
  subnet_id      = aws_subnet.public_use2c.id
  network_acl_id = aws_network_acl.standard.id
}
