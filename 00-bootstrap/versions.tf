terraform {
  # 1. Pin the Terraform CLI version
  required_version = ">= 1.5.0, < 2.0.0"

  # 2. Pin Provider sources and version constraints
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Pessimistic operator: allows >= 6.0.0, < 7.0.0
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}
