output "bucket_name" {
  value       = var.s3_bucket_name
  description = "Nome do bucket"
}

output "domain_name" {
  value       = aws_s3_bucket.bucket.bucket_regional_domain_name
  description = "Domínio do bucket"
}
