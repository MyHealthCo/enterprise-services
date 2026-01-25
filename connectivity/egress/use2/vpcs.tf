resource "aws_vpc" "main" {
  provider             = aws.use2
  cidr_block           = var.cidr_primary
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "egress"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "usable_cidr" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_usable
}

resource "aws_flow_log" "egress" {
  provider        = aws.use2
  traffic_type    = "ALL"
  log_destination = aws_cloudwatch_log_group.flow_logs.arn
  iam_role_arn    = aws_iam_role.flow_logs.arn
  vpc_id          = aws_vpc.main.id
}
