resource "aws_vpc_endpoint" "autoscaling" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.region}.autoscaling"

  subnet_ids = [
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id
  ]

  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "Autoscaling"
  }
}

resource "aws_vpc_endpoint_policy" "autoscaling" {
  provider        = aws.use2
  vpc_endpoint_id = aws_vpc_endpoint.autoscaling.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowAutoscalingAccessOnlyFromOrganization"
        Effect    = "Allow"
        Principal = "*"
        Action    = "autoscaling:*"
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

resource "aws_vpc_endpoint" "ec2" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.region}.ec2"

  subnet_ids = [
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id
  ]

  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "EC2"
  }
}

resource "aws_vpc_endpoint_policy" "ec2" {
  provider        = aws.use2
  vpc_endpoint_id = aws_vpc_endpoint.ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowEC2AccessOnlyFromOrganization"
        Effect    = "Allow"
        Principal = "*"
        Action    = "ec2:*"
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

resource "aws_vpc_endpoint" "eks" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.region}.eks"

  subnet_ids = [
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id
  ]

  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "EKS"
  }
}

resource "aws_vpc_endpoint" "eks_auth" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.region}.eks-auth"

  subnet_ids = [
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id
  ]

  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "EKS-Auth"
  }
}

resource "aws_vpc_endpoint_policy" "eks_auth" {
  provider        = aws.use2
  vpc_endpoint_id = aws_vpc_endpoint.eks_auth.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowEKSAuthAccessOnlyFromOrganization"
        Effect    = "Allow"
        Principal = "*"
        Action    = "eks-auth:*"
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

resource "aws_vpc_endpoint" "elb" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.region}.elasticloadbalancing"

  subnet_ids = [
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id
  ]

  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "ELB"
  }
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

resource "aws_vpc_endpoint" "sts" {
  provider            = aws.use2
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.region}.sts"

  subnet_ids = [
    aws_subnet.service_endpoint_a.id,
    aws_subnet.service_endpoint_b.id,
    aws_subnet.service_endpoint_c.id
  ]

  security_group_ids = [aws_security_group.service_endpoint_sg.id]

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "STS"
  }
}
