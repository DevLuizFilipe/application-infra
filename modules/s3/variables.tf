variable "s3_bucket_name" {
  type        = string
  description = "Nome do bucket"
}

variable "s3_site_index" {
  type        = string
  description = "Index do site estático"
}

variable "s3_site_error" {
  type        = string
  description = "Error do site estático"
}
