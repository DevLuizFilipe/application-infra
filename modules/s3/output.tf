output "bucket_name" {
  value       = var.s3_bucket_name
  description = "Nome do bucket"
}

output "domain_name" {
  value       = aws_s3_bucket.bucket.website_domain
  description = "Domínio do bucket"
}
