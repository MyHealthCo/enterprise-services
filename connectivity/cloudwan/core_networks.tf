resource "aws_networkmanager_core_network" "main" {
  global_network_id    = aws_networkmanager_global_network.main.id
  base_policy_document = data.aws_networkmanager_core_network_policy_document.base.json
  create_base_policy   = true
}
