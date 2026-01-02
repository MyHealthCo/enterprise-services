resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  provider          = aws.use2
  name              = "/aws/vpc/compute-use2"
  log_group_class   = "STANDARD"
  retention_in_days = 1

  tags = {
    Name = "compute-use2"
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
    Name = "compute-use2-flow-logs"
  }
}

resource "aws_iam_role" "vpc_flow_logs" {
  provider = aws.use2
  name     = "compute-use2-vpc-flow-logs"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowVPCFlowLogsAssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "compute-use2-vpc-flow-logs"
  }
}

resource "aws_iam_role_policy" "vpc_flow_logs" {
  provider = aws.use2
  name     = "compute-use2-vpc-flow-logs-policy"
  role     = aws_iam_role.vpc_flow_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowVPCFlowLogsToCloudWatchLogs"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      }
    ]
  })
}
