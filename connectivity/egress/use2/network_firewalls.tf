resource "aws_networkfirewall_firewall" "egress" {
  provider            = aws.use2
  name                = "egress-firewall"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.egress.arn
  vpc_id              = aws_vpc.main.id
  enabled_analysis_types = [
    "HTTP_HOST",
    "TLS_SNI",
  ]

  subnet_mapping {
    subnet_id = aws_subnet.inspection_a.id
  }
  subnet_mapping {
    subnet_id = aws_subnet.inspection_b.id
  }
  subnet_mapping {
    subnet_id = aws_subnet.inspection_c.id
  }

  tags = {
    Name = "egress-firewall"
  }
}

resource "aws_networkfirewall_firewall_policy" "egress" {
  provider = aws.use2
  name     = "egress-policy"

  firewall_policy {
    stateful_default_actions = [
      "aws:alert_established",
      "aws:alert_strict",
      "aws:drop_established",
      "aws:drop_strict",
    ]

    stateful_engine_options {
      rule_order = "STRICT_ORDER"
    }

    stateful_rule_group_reference {
      priority     = 100
      resource_arn = aws_networkfirewall_rule_group.egress_test.arn
    }

    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:drop"]
  }

  tags = {
    Name = "egress"
  }
}

resource "aws_networkfirewall_rule_group" "egress_test" {
  provider = aws.use2
  name     = "egress-test"
  capacity = 1
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "ALLOWLIST"
        target_types = [
          "HTTP_HOST",
          "TLS_SNI",
        ]
        targets = [
          "ec2.amazonaws.com"
        ]
      }
    }

    stateful_rule_options {
      rule_order = "STRICT_ORDER"
    }
  }

  tags = {
    Name           = "egress-test"
    TradingPartner = "AWS"
  }
}

resource "aws_networkfirewall_logging_configuration" "egress" {
  provider     = aws.use2
  firewall_arn = aws_networkfirewall_firewall.egress.arn

  logging_configuration {
    log_destination_config {
      log_destination = {
        logGroup = aws_cloudwatch_log_group.network_firewall.name
      }
      log_destination_type = "CloudWatchLogs"
      log_type             = "ALERT"
    }

    log_destination_config {
      log_destination = {
        logGroup = aws_cloudwatch_log_group.network_firewall.name
      }
      log_destination_type = "CloudWatchLogs"
      log_type             = "FLOW"
    }

    log_destination_config {
      log_destination = {
        logGroup = aws_cloudwatch_log_group.network_firewall.name
      }
      log_destination_type = "CloudWatchLogs"
      log_type             = "TLS"
    }
  }
}

locals {
  firewall_endpoints = {
    for state in aws_networkfirewall_firewall.egress.firewall_status[0].sync_states :
    state.availability_zone => state.attachment[0].endpoint_id
  }
}

output "firewall_endpoints" {
  value = local.firewall_endpoints
}
