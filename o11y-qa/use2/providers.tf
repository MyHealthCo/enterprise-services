provider "aws" {
  alias   = "use2"
  region  = "us-east-2"
  profile = "MyHealthCo-o11y-qa"

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
  profile = "MyHealthCo-o11y-qa"

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
