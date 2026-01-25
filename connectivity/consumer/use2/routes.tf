# Intentionally using a single default route to direct all traffic to the core network due to consumer VPC design simplicity.
resource "aws_route" "default_route" {
  provider               = aws.use2
  route_table_id         = aws_route_table.internal.id
  destination_cidr_block = "0.0.0.0/0"
  core_network_arn       = var.core_network_arn
  depends_on             = [aws_networkmanager_attachment_accepter.accept]
}
