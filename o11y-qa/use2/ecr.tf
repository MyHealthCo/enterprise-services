resource "aws_ecr_repository" "otel_collector" {
  provider             = aws.use2
  name                 = "o11y/otel-collector-contrib"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "o11y-qa-otel-collector-repo"
  }
}
