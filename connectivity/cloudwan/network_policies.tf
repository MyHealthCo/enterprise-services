data "aws_networkmanager_core_network_policy_document" "main" {
  provider = aws.use2

  core_network_configuration {
    asn_ranges = ["4200000000-4294967294"]

    edge_locations {
      location = "us-east-2"
      asn      = "4200000102"
    }

    edge_locations {
      location = "us-west-2"
      asn      = "4200000202"
    }
  }

  segments {
    name                          = "prod"
    description                   = "Production network segment for secure traffic"
    require_attachment_acceptance = true
  }
  segments {
    name                          = "qa"
    description                   = "Quality Assurance mirror network for prod segment"
    require_attachment_acceptance = true
  }
  segments {
    name                          = "null"
    description                   = "Blackhole segment for unwanted traffic"
    require_attachment_acceptance = false
  }

  network_function_groups {
    name                          = "secure-egress-qa"
    description                   = "Network Function Group for QA egress traffic with inspection"
    require_attachment_acceptance = true
  }

  segment_actions {
    action      = "send-to"
    description = "Ships all QA outbound traffic out through the secure egress Network Function Group"
    segment     = "qa"

    via {
      network_function_groups = ["secure-egress-qa"]

      with_edge_override {
        edge_sets = [
          ["us-east-2"]
        ]

        use_edge_location = "us-east-2"
      }
    }
  }

  attachment_policies {
    rule_number     = 100
    condition_logic = "or"

    conditions {
      type     = "tag-value"
      operator = "equals"
      key      = "NetworkSegment"
      value    = "qa"
    }

    action {
      association_method = "constant"
      segment            = "qa"
    }
  }

  attachment_policies {
    rule_number     = 200
    condition_logic = "or"

    conditions {
      type     = "tag-value"
      operator = "equals"
      key      = "NetworkSegment"
      value    = "prod"
    }

    action {
      association_method = "constant"
      segment            = "prod"
    }
  }

  attachment_policies {
    rule_number     = 500
    condition_logic = "or"
    conditions {
      type     = "tag-value"
      operator = "equals"
      key      = "NetworkFunctionGroup"
      value    = "secure-egress-qa"
    }
    action {
      add_to_network_function_group = "secure-egress-qa"
    }
  }

  attachment_policies {
    rule_number     = 999
    condition_logic = "or"

    conditions {
      type     = "tag-value"
      operator = "equals"
      key      = "NetworkSegment"
      value    = "null"
    }
    action {
      association_method = "constant"
      segment            = "null"
    }
  }
}
