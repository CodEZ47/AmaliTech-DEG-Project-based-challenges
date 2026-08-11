output "vela_instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.vela_web.id
}

output "vela_instance_public_ip" {
  description = "Public IP address of the EC2 instance."
  value       = aws_instance.vela_web.public_ip
}

output "vela_web_sg_id" {
  description = "ID of the web-sg security group."
  value       = aws_security_group.vela_web_sg.id
}

output "vela_iam_role_arn" {
  description = "ARN of the IAM role attached to the EC2 instance."
  value       = aws_iam_role.vela_ec2_s3_role.arn
}

output "vela_iam_instance_profile_name" {
  description = "Name of the IAM instance profile attached to the EC2 instance."
  value       = aws_iam_instance_profile.vela_ec2_s3_profile.name
}