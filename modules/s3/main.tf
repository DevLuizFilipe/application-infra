resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
  acl    = var.s3_acl
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
