provider "aws" {
}
terraform {
  backend "s3" {
    bucket = "tfstate-lab-application"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
