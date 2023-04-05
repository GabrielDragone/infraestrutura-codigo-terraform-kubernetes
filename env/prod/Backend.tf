terraform {
  backend "s3" {
    bucket = "terraform-gabriel-example"
    key    = "Prod/terraform.tfstate"
    region = "us-east-1"
  }
}