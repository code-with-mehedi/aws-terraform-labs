# ─────────────────────────────────────
# AWS Provider Configuration
# ─────────────────────────────────────

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Repository  = "https://github.com/code-with-mehedi/aws-terraform-labs"
    }
  }
}

# Provider alias for global services (CloudFront, ACM, WAF)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
