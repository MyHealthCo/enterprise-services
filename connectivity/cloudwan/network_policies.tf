data "aws_networkmanager_core_network_policy_document" "base" {
  core_network_configuration {
    asn_ranges = ["65022-65534"]

    edge_locations {
      location = "us-east-2"
      asn      = "65500"
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
}

data "aws_networkmanager_core_network_policy_document" "extension" {
  core_network_configuration {
    asn_ranges = ["65022-65534"]

    edge_locations {
      location = "us-east-2"
      asn      = "65500"
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

  segment_actions {
    action  = "create-route"
    segment = "qa"
    destination_cidr_blocks = [
      "0.0.0.0/0"
    ]
    destinations = [
      aws_networkmanager_vpc_attachment.attachment.id,
    ]
  }
}

resource "aws_networkmanager_core_network_policy_attachment" "extension" {
  core_network_id = aws_networkmanager_core_network.main.id
  policy_document = data.aws_networkmanager_core_network_policy_document.extension.json
}
