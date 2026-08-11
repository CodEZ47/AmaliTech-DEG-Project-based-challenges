variable "vela_vpc_id" {
  description = "ID of the VPC from networking module"
  type        = string
}

variable "vela_public_subnet_id" {
  description = "ID of the public subnet from networking module"
  type        = string
}

variable "vela_admin_ip_cidr" {
  description = "admin IP address allowed to ssh"
  type        = string
}

variable "vela_instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "vela_s3_bucket_arn" {
  description = "ARN of the S3 bucket (from the storage module) that this instance's IAM role is allowed to GetObject/PutObject on."
  type        = string
}