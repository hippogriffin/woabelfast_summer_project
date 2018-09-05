# Grabbing data from the DMZ Remote State file 

data "terraform_remote_state" "dmz_remote_state" {
  backend = "s3"
  config {
    bucket = "woa-belfast"
    key = "dmz/woa.tfstate"
    region = "eu-west-1"
  }
}
