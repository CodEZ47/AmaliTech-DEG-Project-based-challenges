output "vela_state_bucket_name" {
  description = "Name of the S3 bucket to reference in each environment's backend \"s3\" block."
  value       = aws_s3_bucket.vela_terraform_state.id
}