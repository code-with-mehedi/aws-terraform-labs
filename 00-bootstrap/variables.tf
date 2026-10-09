variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "ap-southeast-1"
}

variable "state_bucket_name" {
  description = "Globally unique name for the remote state S3 bucket"
  type        = string
  default     = "code-with-mehedi-tfstate-ap-southeast-1"
}
