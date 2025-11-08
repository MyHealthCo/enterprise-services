resource "aws_networkfirewall_firewall" "o11y_qa_firewall" {
  name                   = "o11y-qa-firewall"
  firewall_policy_arn    = aws_network_firewall_firewall_policy.o11y_qa_firewall_policy.arn
  vpc_id                 = aws_vpc.main.id
  enabled_analysis_types = ["HTTP_HOST"]

  subnet_mappings {
    subnet_id = aws_subnet.inspection_use2a.id
  }
  subnet_mappings {
    subnet_id = aws_subnet.inspection_use2b.id
  }
  subnet_mappings {
    subnet_id = aws_subnet.inspection_use2c.id
  }

  tags = {
    Name = "o11y-qa-firewall"
  }
}

resource "aws_networkfirewall_firewall_policy" "o11y_qa_firewall_policy" {
  name = "o11y-qa-firewall-policy"

  firewall_policy {
    stateful_rule_group_references {
      resource_arn = aws_network_firewall_rule_group.o11y_honeycomb_rule_group.arn
    }
  }

  tags = {
    Name = "o11y-qa-firewall-policy"
  }
}

resource "aws_networkfirewall_rule_group" "o11y_honeycomb_rule_group" {
  name     = "o11y-honeycomb-rule-group"
  capacity = 100
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rule_source_list {
        generated_rules_type = "ALLOWLIST"
        target_types = ["HTTP_HOST"]
        targets = ["api.honeycomb.io"]
      }
    }
  }

  tags = {
    Name = "o11y-honeycomb-rule-group"
    TradingPartner = "Honeycomb.io"
  }
}

