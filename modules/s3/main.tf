resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
  acl    = var.s3_acl

  website {
    index_document = var.s3_site_index
    error_document = var.s3_site_error
  }
}
