variable "vela_region" {
  description = "AWS region to create the state bucket in."
  type        = string
  default     = "ap-southeast-2"
}

variable "vela_state_bucket_name" {
  description = "Globally unique name for the Terraform state bucket."
  type        = string
  default     = "vela-terraform-state-8272ks83k"
}