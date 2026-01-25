resource "aws_ram_resource_share" "core_network_to_egress" {
  provider                  = aws.cloudwan
  allow_external_principals = false
  name                      = "corenetwork-to-egress"
}

resource "aws_ram_resource_association" "core_network_to_egress" {
  provider           = aws.cloudwan
  resource_share_arn = aws_ram_resource_share.core_network_to_egress.arn
  resource_arn       = var.core_network_arn
}

resource "aws_ram_principal_association" "core_network_to_egress" {
  provider           = aws.cloudwan
  resource_share_arn = aws_ram_resource_share.core_network_to_egress.arn
  principal          = data.aws_caller_identity.current.account_id

  depends_on = [aws_ram_resource_association.core_network_to_egress]
}

resource "aws_ram_resource_share_accepter" "core_network_to_egress" {
  provider  = aws.use2
  share_arn = aws_ram_resource_share.core_network_to_egress.arn

  depends_on = [aws_ram_principal_association.core_network_to_egress]
}
