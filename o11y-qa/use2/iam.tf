data "aws_caller_identity" "current" {
    provider = aws.use2
}

resource "aws_iam_policy" "network_firewall" {
    provider = aws.use2
    name = "NetworkFirewall-LoggingPolicy"
    description = "Policy to allow Network Firewall to write logs to CloudWatch"
    path = "/o11y/"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Sid = "NetworkFirewall-Logging"
                Effect = "Allow"
                Action = [
                    "logs:CreateLogGroupDelivery",
                    "logs:GetLogDelivery",
                    "logs:UpdateLogDelivery",
                    "logs:DeleteLogDelivery",
                    "logs:ListLogDeliveries",
                ]
                Resource = [
                    "arn:aws:logs:${aws_iam_policy.network_firewall.provider.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/network-firewall/*"
                ]
            },
            {
                Sid = "NetworkFirewall-CloudWatchLogs"
                Effect = "Allow"
                Action = [
                    "logs:PutResourcePolicy",
                    "logs:DescribeResourcePolicies",
                    "logs:DescribeLogGroups",
                ]
                Resource = [
                    "arn:aws:logs:${aws_iam_policy.network_firewall.provider.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/network-firewall/*"
                ]
            },
            {
                Sid = "FirewallLoggingSearch"
                Effect = "Allow"
                Action = [
                    "logs:StartQuery",
                    "logs:GetQueryResults",
                ],
                Resource = [
                    "arn:aws:logs:${aws_iam_policy.network_firewall.provider.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/network-firewall/*"
                ]
            }
        ]
    })
}

resource "aws_iam_role" "network_firewall" {
    provider = aws.use2
    name = "NetworkFirewall-LoggingRole"
    description = "Role to allow Network Firewall to write logs to CloudWatch"
    path = "/o11y/"

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
    provider = aws.use2
    role       = aws_iam_role.network_firewall.name
    policy_arn = aws_iam_policy.network_firewall.arn
}

resource "aws_iam_policy" "o11y_gateway_execution" {
    provider = aws.use2
    name = "o11y-Gateway-Collector-RuntimePolicy"
    description = "Policy to allow o11y Gateway Collector to Execute"
    path = "/o11y/"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Sid = "AllowECRAuthentication"
                Effect = "Allow"
                Action = [
                    "ecr:GetAuthorizationToken",
                ]
                Resource = "*"
            },
            {
                Sid = "AllowECRImagePull"
                Effect = "Allow"
                Action = [
                    "ecr:BatchCheckLayerAvailability",
                    "ecr:BatchGetImage",
                    "ecr:GetDownloadUrlForLayer",
                ]
                Resource = aws_ecr_repository.gateway_collector.arn
                Condition = {
                    StringEquals = {
                        "aws:sourceVpce": aws_vpc_endpoint.ecr_dkr.id,
                        "aws:sourceVpc": aws_vpc.main.id
                    }
                }
            },
            {
                Sid = "AllowLogActions"
                Effect = "Allow"
                Action = [
                    "logs:CreateLogStream",
                    "logs:PutLogEvents",
                    "logs:ListTagsLogGroup",
                    "logs:PutLogEvents",
                ]
                Resource = [
                    "arn:aws:logs:${aws_iam_policy.o11y_gateway_execution.provider.region}:${data.aws_caller_identity.current.account_id}:log-group:/ecs/gateway-collector",
                    "arn:aws:logs:${aws_iam_policy.o11y_gateway_execution.provider.region}:${data.aws_caller_identity.current.account_id}:log-group:/ecs/gateway-collector:log-stream:*",
                    "arn:aws:logs:${aws_iam_policy.o11y_gateway_execution.provider.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/ecs/containerinsights/gateway-collector/performance",
                ]
            }
        ]
    })
}

resource "aws_iam_role" "o11y_gateway_execution" {
    provider = aws.use2
    name = "o11y-Gateway-Collector-RuntimeRole"
    description = "Role to allow o11y Gateway Collector to Execute"
    path = "/o11y/"

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
    provider = aws.use2
    role       = aws_iam_role.o11y_gateway_execution.name
    policy_arn = aws_iam_policy.o11y_gateway_execution.arn
}
