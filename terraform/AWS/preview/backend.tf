# Remote State Backend
terraform {
  backend "s3" {
    bucket = "woa-belfast"
    key = "preview/woa.tfstate"
    region = "eu-west-1"
  }
}