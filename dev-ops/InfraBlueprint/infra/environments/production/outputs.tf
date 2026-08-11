output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance."
  value       = module.compute.vela_instance_public_ip
}

output "rds_endpoint" {
  description = "Connection endpoint for the RDS instance."
  value       = module.database.vela_db_endpoint
}

output "s3_bucket_name" {
  description = "Name of the S3 asssets bucket."
  value       = module.storage.vela_s3_bucket_name
}