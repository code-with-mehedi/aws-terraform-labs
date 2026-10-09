output "bucket_id" {
  description = "The name/ID of the S3 state bucket"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "The ARN of the S3 state bucket"
  value       = aws_s3_bucket.this.arn
}

output "bucket_region" {
  description = "The AWS region where the bucket was created"
  value       = aws_s3_bucket.this.region
}

output "bucket_domain_name" {
  description = "The bucket domain name (e.g. bucket.s3.amazonaws.com)"
  value       = aws_s3_bucket.this.bucket_domain_name
}
