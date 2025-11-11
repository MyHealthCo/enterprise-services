resource "aws_ecr_repository" "gateway_collector" {
  provider             = aws.use2
  name                 = "o11y/gateway-collector"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "o11y-qa-otel-gateway-collector-repo"
  }
}
