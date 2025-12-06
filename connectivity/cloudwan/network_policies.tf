data "aws_networkmanager_core_network_policy_document" "main" {
  core_network_configuration {
    asn_ranges = ["4200000000-4294967294"]

    edge_locations {
      location = "us-east-2"
      asn      = "4200000000"
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
    require_attachment_acceptance = true
  }

  network_function_groups {
    name                          = "secure-egress-qa"
    description                   = "Network Function Group for QA egress traffic with inspection"
    require_attachment_acceptance = true
  }

  attachment_policies {
    rule_number     = 100
    condition_logic = "or"

    conditions {
      type     = "tag-value"
      operator = "equals"
      key      = "segment"
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
      key      = "segment"
      value    = "prod"
    }

    action {
      association_method = "constant"
      segment            = "prod"
    }
  }

  segment_actions {
    action       = "send-to"
    description  = "Ships traffic to a black hole from when nothing can escape"
    destinations = ["blackhole"]
    segment      = "null"
  }
  segment_actions {
    action      = "send-via"
    segment     = "qa"
    description = "Route QA traffic through secure egress Network Function Group"
    mode        = "attachment-route"

    via {
      network_function_groups = ["secure-egress-qa"]
    }
  }

}
