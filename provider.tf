provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = module.bucket-tf.bucket_name
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
