data "aws_caller_identity" "current" {
  provider = aws.use2
}

data "aws_organizations_organization" "current" {
  provider = aws.use2
}

data "aws_region" "current" {
  provider = aws.use2
}
