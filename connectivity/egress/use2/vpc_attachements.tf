variable "core_network_arn" {
  description = "Core Network ARN"
  type        = string
  default     = ""
}

variable "core_network_id" {
  description = "Core Network ID"
  type        = string
  default     = ""
}

# Core Network
resource "aws_networkmanager_vpc_attachment" "attachment" {
  provider        = aws.use2
  core_network_id = var.core_network_id
  vpc_arn         = aws_vpc.main.arn

  subnet_arns = [
    aws_subnet.internal_a.arn,
    aws_subnet.internal_b.arn,
    aws_subnet.internal_c.arn,
  ]

  options {
    appliance_mode_support             = true
    dns_support                        = true
    ipv6_support                       = false
    security_group_referencing_support = false
  }

  tags = {
    Name                 = "egress-vpc-cw-attach"
    NetworkFunctionGroup = "secure-egress-qa"
  }
}

resource "aws_networkmanager_attachment_accepter" "accept" {
  provider        = aws.cloudwan
  attachment_id   = aws_networkmanager_vpc_attachment.attachment.id
  attachment_type = "VPC"
}
