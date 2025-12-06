resource "aws_cloudwatch_log_group" "network_firewall_alerts" {
  provider          = aws.use2
  name              = "/aws/network-firewall/egress-alerts"
  log_group_class   = "STANDARD"
  retention_in_days = 1

  tags = {
    Name = "egress-firewall-alerts"
  }
}

resource "aws_cloudwatch_log_group" "network_firewall_flows" {
  provider          = aws.use2
  name              = "/aws/network-firewall/egress-flows"
  log_group_class   = "STANDARD"
  retention_in_days = 1

  tags = {
    Name = "egress-firewall-flows"
  }
}

resource "aws_cloudwatch_log_group" "network_firewall_tls" {
  provider          = aws.use2
  name              = "/aws/network-firewall/egress-tls"
  log_group_class   = "STANDARD"
  retention_in_days = 1

  tags = {
    Name = "egress-firewall-tls"
  }
}
