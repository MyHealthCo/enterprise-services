resource "aws_networkfirewall_firewall" "o11y_qa_firewall" {
  provider               = aws.use2
  name                   = "o11y-qa-firewall"
  firewall_policy_arn    = aws_networkfirewall_firewall_policy.o11y_qa_firewall_policy.arn
  vpc_id                 = aws_vpc.main.id
  enabled_analysis_types = ["HTTP_HOST"]

  subnet_mapping {
    subnet_id = aws_subnet.inspection_use2a.id
  }
  subnet_mapping {
    subnet_id = aws_subnet.inspection_use2b.id
  }
  subnet_mapping {
    subnet_id = aws_subnet.inspection_use2c.id
  }

  tags = {
    Name = "o11y-qa-firewall"
  }
}

resource "aws_networkfirewall_firewall_policy" "o11y_qa_firewall_policy" {
  provider = aws.use2
  name     = "o11y-qa-firewall-policy"

  firewall_policy {
    stateless_default_actions          = ["aws:pass"]
    stateless_fragment_default_actions = ["aws:drop"]
    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.o11y_honeycomb_rule_group.arn
    }
  }

  tags = {
    Name = "o11y-qa-firewall-policy"
  }
}

resource "aws_networkfirewall_rule_group" "o11y_honeycomb_rule_group" {
  provider = aws.use2
  name     = "o11y-honeycomb-rule-group"
  capacity = 100
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "ALLOWLIST"
        target_types = [
          "HTTP_HOST",
          "TLS_SNI"
        ]
        targets = [
          "api.honeycomb.io"
        ]
      }
    }
  }

  tags = {
    Name           = "o11y-honeycomb-rule-group"
    TradingPartner = "Honeycomb.io"
  }
}

resource "aws_networkfirewall_logging_configuration" "o11y_qa_firewall_logging" {
  provider     = aws.use2
  firewall_arn = aws_networkfirewall_firewall.o11y_qa_firewall.arn

  logging_configuration {
    log_destination_config {
      log_destination = {
        logGroup = aws_cloudwatch_log_group.network_firewall_log_group.name
      }
      log_destination_type = "CloudWatchLogs"
      log_type             = "ALERT"
    }


    log_destination_config {
      log_destination = {
        logGroup = aws_cloudwatch_log_group.network_firewall_log_group.name
      }
      log_destination_type = "CloudWatchLogs"
      log_type             = "FLOW"
    }


    log_destination_config {
      log_destination = {
        logGroup = aws_cloudwatch_log_group.network_firewall_log_group.name
      }
      log_destination_type = "CloudWatchLogs"
      log_type             = "TLS"
    }

  }
}

resource "aws_cloudwatch_log_group" "network_firewall_log_group" {
  provider          = aws.use2
  name              = "/aws/network-firewall/o11y-qa-firewall-log-group"
  log_group_class   = "DELIVERY"
  retention_in_days = 1

  tags = {
    Name = "o11y-qa-firewall-log-group"
  }
}

locals {
  firewall_endpoints = {
    for state in aws_networkfirewall_firewall.o11y_qa_firewall.firewall_status[0].sync_states :
    state.availability_zone => state.attachment[0].endpoint_id
  }
}

output "firewall_endpoints" {
  value = local.firewall_endpoints
}
