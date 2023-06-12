resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = var.cdn_damin_name
    origin_id   = var.cdn_origin_id
    origin_path = var.cdn_target_path
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = var.cdn_enabled
  is_ipv6_enabled     = var.cdn_ipv6
  default_root_object = var.cdn_root_object

  default_cache_behavior {
    allowed_methods  = var.cdn_allowed_methods
    cached_methods   = var.cdn_cached_methods
    target_origin_id = var.cdn_cache_target_origin

    forwarded_values {
      query_string = var.cdn_query_string
      cookies {
        forward = var.cdn_cookies
      }
    }

    viewer_protocol_policy = var.cdn_protocol_policy
    min_ttl                = var.cdn_min_ttl
    default_ttl            = var.cdn_default_ttl
    max_ttl                = var.cdn_max_ttl
  }

  restrictions {
    geo_restriction {
      restriction_type = var.cdn_geo_restriction
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cdn_certificate_default
  }
}
