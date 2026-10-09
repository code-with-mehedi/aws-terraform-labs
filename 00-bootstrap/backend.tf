terraform {
  backend "s3" {
    bucket       = "code-with-mehedi-tfstate-ap-southeast-1"
    key          = "bootstrap/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
    use_lockfile = true
  }
}
