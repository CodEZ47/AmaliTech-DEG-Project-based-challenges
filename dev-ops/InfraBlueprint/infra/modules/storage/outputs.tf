output "vela_s3_bucket_name" {
  description = "Name of the S3 bucket."
  value       = aws_s3_bucket.vela_static_assets.id
}

output "vela_s3_bucket_arn" {
  description = "ARN of the S3 bucket."
  value       = aws_s3_bucket.vela_static_assets.arn
}