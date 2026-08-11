resource "aws_s3_bucket" "vela_static_assets" {
  bucket = var.vela_s3_bucket_name
}

resource "aws_s3_bucket_public_access_block" "vela_static_assets" {
  bucket = aws_s3_bucket.vela_static_assets.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "vela_static_assets" {
  bucket = aws_s3_bucket.vela_static_assets.id

  versioning_configuration {
    status = "Enabled"
  }
}