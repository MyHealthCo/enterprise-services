# VPC Endpoints
resource "aws_vpc_endpoint" "ecr_api" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.region}.ecr.api"

  subnet_ids = [
    aws_subnet.service_endpoint_use2a.id,
    aws_subnet.service_endpoint_use2b.id,
    aws_subnet.service_endpoint_use2c.id,
  ]
  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "ECR-API"
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

resource "aws_vpc_endpoint" "ecr_dkr" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.region}.ecr.dkr"

  subnet_ids = [
    aws_subnet.service_endpoint_use2a.id,
    aws_subnet.service_endpoint_use2b.id,
    aws_subnet.service_endpoint_use2c.id,
  ]
  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "ECR-DKR"
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

resource "aws_vpc_endpoint" "logs" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.region}.logs"

  subnet_ids = [
    aws_subnet.service_endpoint_use2a.id,
    aws_subnet.service_endpoint_use2b.id,
    aws_subnet.service_endpoint_use2c.id,
  ]
  security_group_ids = [aws_security_group.service_endpoint_sg.id]

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

resource "aws_vpc_endpoint" "s3" {
  provider     = aws.use2
  service_name = "com.amazonaws.${data.aws_region.current.region}.s3"

  vpc_endpoint_type = "Gateway"
  vpc_id            = aws_vpc.main.id

  route_table_ids = [
    aws_route_table.private_use2a.id,
    aws_route_table.private_use2b.id,
    aws_route_table.private_use2c.id,
  ]

  tags = {
    Name = "s3-Gateway"
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
        Resource  = "arn:aws:s3:::prod-${data.aws_region.current.region}-starport-layer-bucket/*"
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
          "arn:aws:s3:::cloudformation-waitcondition-${data.aws_region.current.region}/*",
        ]

      }
    ]
  })
}

resource "aws_vpc_endpoint" "secrets_manager" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.region}.secretsmanager"

  subnet_ids = [
    aws_subnet.service_endpoint_use2a.id,
    aws_subnet.service_endpoint_use2b.id,
    aws_subnet.service_endpoint_use2c.id,
  ]
  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "secrets-manager"
  }
}

resource "aws_vpc_endpoint_policy" "secrets_manager" {
  provider        = aws.use2
  vpc_endpoint_id = aws_vpc_endpoint.secrets_manager.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowSecretsManagerFromOrgOnly"
        Effect    = "Allow"
        Principal = "*"
        Action    = "secretsmanager:*"
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
