resource "aws_cloudwatch_log_group" "network_firewall" {
  provider          = aws.use2
  name              = "/aws/network-firewall/egress"
  log_group_class   = "STANDARD"
  retention_in_days = 1

  tags = {
    Name = "egress-firewall"
  }
}
