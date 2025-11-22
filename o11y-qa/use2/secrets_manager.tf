# Secrets Manager
resource "aws_secretsmanager_secret" "honeycomb_api_key" {
  provider = aws.use2
  name     = "HoneycombApiKey-20251122T1534"
}
