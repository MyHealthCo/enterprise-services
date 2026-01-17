# Secrets Manager
resource "aws_secretsmanager_secret" "honeycomb_api_key" {
  provider = aws.use2
  name     = "HoneycombApiKey-20251123T1043"
}

output "honeycomb_api_key_arn" {
  value = aws_secretsmanager_secret.honeycomb_api_key.arn
}
