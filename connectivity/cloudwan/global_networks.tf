resource "aws_networkmanager_global_network" "main" {
  provider    = aws.use2
  description = "Main CloudWAN Global Network for MyHealthCo"
}
