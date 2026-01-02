resource "aws_security_group" "service_endpoint" {
  provider    = aws.use2
  name        = "ServiceEndpoint-SG"
  description = "Security group for AWS Service Endpoints"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name         = "service-endpoint"
    AllowedUsage = "ServiceEndpoints"
  }
}

resource "aws_security_group_rule" "service_endpoint_https_inbound" {
  provider          = aws.use2
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.service_endpoint.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow inbound HTTPS traffic to Service Endpoints"
}
