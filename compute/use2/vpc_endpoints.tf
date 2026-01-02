data "aws_caller_identity" "current" {
  provider = aws.use2
}

data "aws_organizations_organization" "current" {
  provider = aws.use2
}

data "aws_region" "current" {
  provider = aws.use2
}

# ECR API Endpoint
resource "aws_vpc_endpoint" "ecr_api" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.api"

  subnet_ids = [
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id,
  ]
  security_group_ids = [aws_security_group.service_endpoint.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "ecr-api"
  }
}

resource "aws_vpc_endpoint_policy" "ecr_api" {
  provider        = aws.use2
  vpc_endpoint_id = aws_vpc_endpoint.ecr_api.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowECRApiAccessOnlyFromOrganization"
        Effect    = "Allow"
        Principal = "*"
        Action    = "ecr:*"
        Resource  = "*"
        Condition = {
          StringEquals = {
            "aws:PrincipalOrgID" : data.aws_organizations_organization.current.id
          }
        }
      }
    ]
  })
}

# ECR DKR Endpoint
resource "aws_vpc_endpoint" "ecr_dkr" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"

  subnet_ids = [
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id,
  ]
  security_group_ids = [aws_security_group.service_endpoint.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "ecr-dkr"
  }
}

resource "aws_vpc_endpoint_policy" "ecr_dkr" {
  provider        = aws.use2
  vpc_endpoint_id = aws_vpc_endpoint.ecr_dkr.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowECRDkrAccessOnlyFromOrganization"
        Effect    = "Allow"
        Principal = "*"
        Action    = "ecr:*"
        Resource  = "*"
        Condition = {
          StringEquals = {
            "aws:PrincipalOrgID" : data.aws_organizations_organization.current.id
          }
        }
      }
    ]
  })
}

# CloudWatch Logs Endpoint
resource "aws_vpc_endpoint" "logs" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.logs"

  subnet_ids = [
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id,
  ]
  security_group_ids = [aws_security_group.service_endpoint.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "logs"
  }
}

resource "aws_vpc_endpoint_policy" "logs" {
  provider        = aws.use2
  vpc_endpoint_id = aws_vpc_endpoint.logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowLogsAccessOnlyFromOrganization"
        Effect    = "Allow"
        Principal = "*"
        Action    = "logs:*"
        Resource  = "*"
        Condition = {
          StringEquals = {
            "aws:PrincipalOrgID" : data.aws_organizations_organization.current.id
          }
        }
      },
      {
        Sid       = "AllowPassRole"
        Effect    = "Allow"
        Principal = "*"
        Action    = "iam:PassRole"
        Resource  = "*"
      }
    ]
  })
}

# S3 Gateway Endpoint
resource "aws_vpc_endpoint" "s3" {
  provider     = aws.use2
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"

  vpc_endpoint_type = "Gateway"
  vpc_id            = aws_vpc.main.id

  route_table_ids = [
    aws_route_table.internal_a.id,
    aws_route_table.internal_b.id,
    aws_route_table.internal_c.id,
  ]

  tags = {
    Name = "s3"
  }
}

resource "aws_vpc_endpoint_policy" "s3" {
  provider        = aws.use2
  vpc_endpoint_id = aws_vpc_endpoint.s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowECRImageLayerAccess"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::prod-${data.aws_region.current.name}-starport-layer-bucket/*"
      },
      {
        Sid       = "AllowAllS3AccessOnlyFromOrganization"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:*"
        Resource  = "*"
        Condition = {
          StringEquals = {
            "aws:PrincipalOrgID" : data.aws_organizations_organization.current.id
          }
        }
      },
      {
        Sid       = "AllowPutsForCFTs"
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Resource = [
          "arn:aws:s3:::prod.${data.aws_caller_identity.current.account_id}.appinfo.src/*",
          "arn:aws:s3:::cloudformation-custom-resource-response-useast2/*",
          "arn:aws:s3:::cloudformation-waitcondition-${data.aws_region.current.name}/*",
        ]
      }
    ]
  })
}
