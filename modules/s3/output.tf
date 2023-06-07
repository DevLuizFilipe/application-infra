output "bucket_name" {
  value = var.s3_bucket_name
}

output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}

output "domain_name" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}