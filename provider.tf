provider "aws" {
  access_key        = var.aws_access_key
  secret_access_key = var.aws_secret_key
  region            = "us-east-1"
}
# terraform {
#   backend "s3" {
#     bucket = module.bucket-tf.bucket_name
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#   }
# }
