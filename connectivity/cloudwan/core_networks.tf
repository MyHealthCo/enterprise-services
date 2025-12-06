resource "aws_networkmanager_core_network" "main" {
  provider             = aws.use2
  global_network_id    = aws_networkmanager_global_network.main.id
  base_policy_document = data.aws_networkmanager_core_network_policy_document.main.json
  create_base_policy   = true
}

output "core_network_arn" {
  value = aws_networkmanager_core_network.main.arn
}
