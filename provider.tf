provider "aws" {
  profile = "default"
}
terraform {
  backend "s3" {
    bucket = "tfstate-lab-waycarbon"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
