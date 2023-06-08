resource "aws_acm_certificate" "certificate" {
  domain_name       = var.acm_domain_name
  validation_method = "DNS"
}
