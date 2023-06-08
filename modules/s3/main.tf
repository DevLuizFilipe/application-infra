resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
  acl    = var.s3_bucket_acl
  versioning {
    enabled = true
    mfa_delete = true
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_sse_configuration" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.s3_site_error
  }

  error_document {
    key = var.s3_site_index
  }
}
