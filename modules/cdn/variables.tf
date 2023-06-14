variable "cdn_damin_name" {
  type        = string
  description = "Nome do domínio do CDN"
}

variable "cdn_origin_id" {
  type        = string
  description = "Nome do bucket"
}

variable "cdn_enabled" {
  type        = string
  description = "Habilitar CDN"
}

variable "cdn_ipv6" {
  type        = string
  description = "Habilitar IPv6"
}

variable "cdn_allowed_methods" {
  type        = list(string)
  description = "Métodos permitidos"
}

variable "cdn_cached_methods" {
  type        = list(string)
  description = "Métodos cacheados"
}

variable "cdn_cache_target_origin" {
  type        = string
  description = "Nome do bucket"
}

variable "cdn_query_string" {
  type        = string
  description = "Habilitar query string"
}

variable "cdn_cookies" {
  type        = string
  description = "Habilitar Cookies"
}

variable "cdn_protocol_policy" {
  type        = string
  description = "Política de protocolo"
}

variable "cdn_min_ttl" {
  type        = string
  description = "Tempo mínimo do ttl"
}

variable "cdn_default_ttl" {
  type        = string
  description = "Tempo padrão do ttl"
}

variable "cdn_max_ttl" {
  type        = string
  description = "Tempo máximo do ttl"
}

variable "cdn_geo_restriction" {
  type        = string
  description = "Restrição geográfica"
}

variable "cdn_certificate_default" {
  type        = string
  description = "Habilitar Certificado padrão"
}

variable "cdn_target_path" {
  type        = string
  description = "Caminho do target"
}
