variable "tag_contact" {
  type    = string
  default = "djfurman@gmail.com"
}

variable "tag_created_via" {
  type    = string
  default = "OpenTofu"
}

variable "tag_env" {
  type    = string
  default = "staging"
}

variable "tag_project" {
  type    = string
  default = "MyHealthCo"
}

variable "tag_purpose" {
  type    = string
  default = "o11y"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  alias   = "use2"
  region  = "us-east-2"
  profile = "MyHealthCo-Connectivity"

  default_tags {
    tags = {
      Contact     = var.tag_contact
      CreatedVia  = var.tag_created_via
      Environment = var.tag_env
      Project     = var.tag_project
      Purpose     = var.tag_purpose
    }
  }
}

provider "aws" {
  alias   = "usw2"
  region  = "us-west-2"
  profile = "MyHealthCo-Connectivity"

  default_tags {
    tags = {
      Contact     = var.tag_contact
      CreatedVia  = var.tag_created_via
      Environment = var.tag_env
      Project     = var.tag_project
      Purpose     = var.tag_purpose
    }
  }
}
