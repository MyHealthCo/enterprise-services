variable "primary_cidr" {
  description = "Primary CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/28"
}

variable "usable_cidr" {
  description = "Usable CIDR range for the VPC"
  type        = string
  default     = "10.2.4.0/23"
}

resource "aws_vpc" "main" {
  provider             = aws.use2
  cidr_block           = var.primary_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "egress"
  }
}

resource "aws-vpc_ipv4_cidr_block_association" "usable_cidr" {
  provider   = aws.use2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.usable_cidr
}
