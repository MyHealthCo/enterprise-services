data "aws_region" "current" {
  provider = aws.use2
}

resource "aws_iam_policy" "network_firewall" {
  provider    = aws.use2
  name        = "NetworkFirewall-LoggingPolicy"
  description = "Policy to allow Network Firewall to write logs to CloudWatch"
  path        = "/o11y/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "NetworkFirewallLogging"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroupDelivery",
          "logs:GetLogDelivery",
          "logs:UpdateLogDelivery",
          "logs:DeleteLogDelivery",
          "logs:ListLogDeliveries",
        ]
        Resource = [
          "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/network-firewall/*"
        ]
      },
      {
        Sid    = "NetworkFirewallCloudWatchLogs"
        Effect = "Allow"
        Action = [
          "logs:PutResourcePolicy",
          "logs:DescribeResourcePolicies",
          "logs:DescribeLogGroups",
        ]
        Resource = [
          "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/network-firewall/*"
        ]
      },
      {
        Sid    = "FirewallLoggingSearch"
        Effect = "Allow"
        Action = [
          "logs:StartQuery",
          "logs:GetQueryResults",
        ],
        Resource = [
          "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/network-firewall/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "network_firewall" {
  provider    = aws.use2
  name        = "NetworkFirewall-LoggingRole"
  description = "Role to allow Network Firewall to write logs to CloudWatch"
  path        = "/o11y/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "network-firewall.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "network_firewall" {
  provider   = aws.use2
  role       = aws_iam_role.network_firewall.name
  policy_arn = aws_iam_policy.network_firewall.arn
}

resource "aws_iam_policy" "o11y_gateway_execution" {
  provider    = aws.use2
  name        = "o11y-Gateway-Collector-RuntimePolicy"
  description = "Policy to allow o11y Gateway Collector to Execute"
  path        = "/o11y/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowECRAuthentication"
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowECRImagePull"
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
        ]
        Resource = aws_ecr_repository.gateway_collector.arn
      },
      {
        Sid    = "AllowLogActions"
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:ListTagsLogGroup",
          "logs:PutLogEvents",
        ]
        Resource = [
          "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:/ecs/gateway-collector",
          "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:/ecs/gateway-collector:log-stream:*",
          "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/ecs/containerinsights/gateway-collector/performance",
        ]
      },
      {
        Sid    = "AllowSecretsFetch"
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath",
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          "${aws_secretsmanager_secret.honeycomb_api_key.arn}"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "o11y_gateway_execution" {
  provider    = aws.use2
  name        = "o11y-Gateway-Collector-RuntimeRole"
  description = "Role to allow o11y Gateway Collector to Execute"
  path        = "/o11y/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "o11y_gateway_execution" {
  provider   = aws.use2
  role       = aws_iam_role.o11y_gateway_execution.name
  policy_arn = aws_iam_policy.o11y_gateway_execution.arn
}
