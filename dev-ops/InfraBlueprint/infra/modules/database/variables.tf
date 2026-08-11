variable "vela_vpc_id" {
  description = "ID of the VPC from the networking module."
  type        = string
}

variable "vela_private_subnet_ids" {
  description = "IDs of the private subnets from the networking module."
  type        = list(string)
}

variable "vela_web_sg_id" {
  description = "ID of web-sg"
  type        = string
}

variable "vela_db_username" {
  description = "Master username for the RDS instance."
  type        = string
  sensitive   = true
}

variable "vela_db_password" {
  description = "Master password for the RDS instance."
  type        = string
  sensitive   = true
}

variable "vela_skip_final_snapshot" {
  description = "Whether to skip the final RDS snapshot on destroy."
  type        = bool
  default     = true
}