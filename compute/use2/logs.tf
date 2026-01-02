resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  provider          = aws.use2
  name              = "/aws/vpc/compute-use2"
  log_group_class   = "STANDARD"
  retention_in_days = 1

  tags = {
    Name = "vpc-flow-logs"
  }
}

resource "aws_flow_log" "main" {
  provider             = aws.use2
  iam_role_arn         = aws_iam_role.vpc_flow_logs.arn
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}
