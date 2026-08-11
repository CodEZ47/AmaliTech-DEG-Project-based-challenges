variable "vela_region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "ap-southeast-2"
}

variable "vela_main_vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "vela_public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
}

variable "vela_private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets."
  type        = list(string)
}

variable "azs" {
  description = "List of Availability Zones to spread subnets across."
  type        = list(string)
}

variable "vela_admin_ip_cidr" {
  description = "Your IP address in CIDR notation, allowed to SSH into the EC2 instance."
  type        = string
}

variable "vela_instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "vela_s3_bucket_name" {
  description = "Globally unique name for the S3 static assets bucket."
  type        = string
}

variable "vela_db_username" {
  description = "Master username for the RDS instance. Must be supplied via *.tfvars — never given a default."
  type        = string
  sensitive   = true
}

variable "vela_db_password" {
  description = "Master password for the RDS instance. Must be supplied via *.tfvars — never given a default."
  type        = string
  sensitive   = true
}

variable "vela_skip_final_snapshot" {
  description = "Whether to skip the final RDS snapshot on destroy."
  type        = bool
  default     = true
}