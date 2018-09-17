# Remote State Backend
terraform {
  backend "s3" {
    bucket = "woa-belfast"
    key = "dmz/woa.tfstate"
    region = "eu-west-1"
  }
}