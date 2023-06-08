provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "tfstate-lab-waycarbon"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
