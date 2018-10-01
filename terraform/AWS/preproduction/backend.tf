# Remote State Backend
terraform {
  backend "s3" {
    bucket = "woa-belfast"
    key    = "preproduction/woa.tfstate"
    region = "eu-west-1"
  }
}
