output "frontend_url" {
  value       = module.bucket_website.domain_name
  description = "URL do frontend"
}

output "backend_url" {
  value       = module.cdn.cloudfront_domain_name
  description = "Dominio do CloudFront"
}
