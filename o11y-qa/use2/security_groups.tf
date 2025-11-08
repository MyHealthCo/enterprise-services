resource "aws_security_group" "lb_sg" {
  provider    = aws.use2
  name        = "LoadBalancer-SG"
  description = "Security group for PrivateLink load balancer"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "LoadBalancer-SG"
  }
}

resource "aws_security_group" "collector_sg" {
  provider    = aws.use2
  name        = "Collector-SG"
  description = "Security group for OTel collector"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "Collector-SG"
  }
}

resource "aws_security_group_rule" "allow_lb_otlp_inbound" {
  provider          = aws.use2
  type              = "ingress"
  from_port         = 9990
  to_port           = 9990
  protocol          = "tcp"
  security_group_id = aws_security_group.lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow inbound TLS traffic"
}


resource "aws_security_group_rule" "allow_lb_otlp_outbound" {
  provider                 = aws.use2
  type                     = "egress"
  from_port                = 9990
  to_port                  = 9990
  protocol                 = "tcp"
  security_group_id        = aws_security_group.lb_sg.id
  source_security_group_id = aws_security_group.collector_sg.id
  description              = "Allow inbound OTel traffic from LoadBalancer-SG"
}


resource "aws_security_group_rule" "allow_collector_otlp_inbound" {
  provider                 = aws.use2
  type                     = "ingress"
  from_port                = 9990
  to_port                  = 9990
  protocol                 = "tcp"
  security_group_id        = aws_security_group.collector_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
  description              = "Allow inbound OTel traffic from LoadBalancer-SG"
}

resource "aws_security_group_rule" "allow_collector_otlp_outbound" {
  provider          = aws.use2
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.collector_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound OTLP traffic"
}
