resource "aws_vpc_endpoint" "ecr_api" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.region}.ecr.api"

  subnet_ids = [
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id
  ]

  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  ip_address_type   = "dualstack"
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
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id
  ]

  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  ip_address_type   = "dualstack"
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
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id,
  ]
  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  ip_address_type   = "dualstack"
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "CloudWatch-Logs"
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
  provider          = aws.use2
  service_name      = "com.amazonaws.${data.aws_region.current.region}.s3"
  vpc_endpoint_type = "Gateway"
  vpc_id            = aws_vpc.main.id

  route_table_ids = [
    aws_route_table.compute.id,
    aws_route_table.service_endpoint.id,
    aws_route_table.compute_native.id,
  ]

  ip_address_type = "dualstack"

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
