variable "bucket_name" {
  description = "Globally unique name for the Terraform state S3 bucket"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "Bucket name must be 3-63 characters, lowercase letters, numbers, hyphens, and periods only."
  }
}

variable "force_destroy" {
  description = "Allow deletion of non-empty bucket (set true only for testing)"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable versioning for state rollback protection"
  type        = bool
  default     = true
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm (AES256 or aws:kms)"
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms"], var.sse_algorithm)
    error_message = "SSE algorithm must be either AES256 or aws:kms."
  }
}

variable "kms_master_key_id" {
  description = "KMS key ARN for encryption (required when sse_algorithm is aws:kms)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
