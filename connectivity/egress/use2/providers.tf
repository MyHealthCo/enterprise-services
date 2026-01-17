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
  alias   = "cloudwan"
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
