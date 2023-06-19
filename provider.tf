provider "aws" {
}
terraform {
  backend "s3" {
    bucket = "tfstate-lab"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
