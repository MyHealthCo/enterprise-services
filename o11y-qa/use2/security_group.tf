resource "aws_security_group" "lb_sg" {
  provider    = aws.use2
  name        = "LoadBalancer-SG"
  description = "Security group for PrivateLink Load Balancer"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name         = "LoadBalancer-SG"
    AllowedUsage = "LoadBalancers,ServiceProviders"
  }
}

resource "aws_security_group" "collector_sg" {
  provider    = aws.use2
  name        = "Collector-SG"
  description = "Security group for OTel collector"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name         = "Collector-SG"
    AllowedUsage = "Processing"
  }
}

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

resource "aws_security_group_rule" "allow_lb_otlp_inbound" {
  provider          = aws.use2
  type              = "ingress"
  from_port         = 9990
  to_port           = 9990
  protocol          = "tcp"
  security_group_id = aws_security_group.lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow inbound TLS traffic from PrivateLink"
}


resource "aws_security_group_rule" "allow_lb_otlp_to_tg" {
  provider                 = aws.use2
  type                     = "egress"
  from_port                = 4317
  to_port                  = 4317
  protocol                 = "tcp"
  security_group_id        = aws_security_group.lb_sg.id
  source_security_group_id = aws_security_group.collector_sg.id
  description              = "Allow inbound OTel traffic from LoadBalancer-SG"
}

resource "aws_security_group_rule" "allows_health_check_traffic_from_lb_to_ecs" {
  provider                 = aws.use2
  type                     = "egress"
  from_port                = 13133
  to_port                  = 13133
  protocol                 = "tcp"
  security_group_id        = aws_security_group.lb_sg.id
  source_security_group_id = aws_security_group.collector_sg.id
  description              = "Allow outbound health check traffic from LoadBalancer-SG"
}


resource "aws_security_group_rule" "allow_collector_otlp_inbound" {
  provider                 = aws.use2
  type                     = "ingress"
  from_port                = 4317
  to_port                  = 4317
  protocol                 = "tcp"
  security_group_id        = aws_security_group.collector_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
  description              = "Allow inbound OTel traffic from LoadBalancer-SG"
}

resource "aws_security_group_rule" "allow_collector_health_inbound" {
  provider                 = aws.use2
  type                     = "ingress"
  from_port                = 13133
  to_port                  = 13133
  protocol                 = "tcp"
  security_group_id        = aws_security_group.collector_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
  description              = "Allow inbound Health Check traffic from LoadBalancer-SG"
}

resource "aws_security_group_rule" "allow_collector_otlp_to_aggregator" {
  provider          = aws.use2
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.collector_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound OTLP traffic"
}

resource "aws_security_group_rule" "allow_collector_https_to_service_endpoint" {
  provider                 = aws.use2
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.collector_sg.id
  source_security_group_id = aws_security_group.service_endpoint_sg.id
  description              = "Allow outbound HTTPS traffic to Service Endpoints"
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

output "app_security_group" {
    value = aws_security_group.collector_sg.id
}
