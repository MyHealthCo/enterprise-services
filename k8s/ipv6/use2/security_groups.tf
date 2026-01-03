resource "aws_security_group" "service_endpoint_sg" {
  provider    = aws.use2
  name        = "ServiceEndpoint-SG"
  description = "Security group for AWS Service Endpoints"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name         = "ServiceEndpoint-SG"
    AllowedUsage = "ServiceEndpoints"
  }
}

resource "aws_security_group_rule" "allow_service_endpoint_https_inbound" {
  provider          = aws.use2
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.service_endpoint_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow inbound HTTPS traffic to Service Endpoints"
}

resource "aws_security_group_rule" "allow_service_endpoint_https_inbound_ipv6" {
  provider          = aws.use2
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.service_endpoint_sg.id
  ipv6_cidr_blocks  = ["::/0"]
  description       = "Allow inbound HTTPS traffic to Service Endpoints over IPv6"
}
