terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.vela_region
}

resource "aws_s3_bucket" "vela_terraform_state" {
  bucket = var.vela_state_bucket_name
}

resource "aws_s3_bucket_versioning" "vela_terraform_state" {
  bucket = aws_s3_bucket.vela_terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "vela_terraform_state" {
  bucket = aws_s3_bucket.vela_terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "vela_terraform_state" {
  bucket = aws_s3_bucket.vela_terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}