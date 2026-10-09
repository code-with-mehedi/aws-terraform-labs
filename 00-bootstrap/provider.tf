# Configure the AWS Provider
provider "aws" {
  region = var.aws_region # e.g. "ap-southeast-1"

  # 1. Default Tags (Golden Practice)
  default_tags {
    tags = {
      Project     = "aws-terraform-labs"
      Environment = "bootstrap"
      ManagedBy   = "Terraform"
      Repository  = "https://github.com/code-with-mehedi/aws-terraform-labs"
    }
  }
}

# 2. Provider Aliases (for multi-region needs, like CloudFront ACM certs in us-east-1)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  default_tags {
    tags = {
      Project   = "aws-terraform-labs"
      ManagedBy = "Terraform"
    }
  }
}
