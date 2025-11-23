resource "aws_cloudwatch_log_group" "network_firewall" {
  provider          = aws.use2
  name              = "/aws/network-firewall/o11y-qa"
  log_group_class   = "STANDARD"
  retention_in_days = 1

  tags = {
    Name = "o11y-qa"
  }
}
