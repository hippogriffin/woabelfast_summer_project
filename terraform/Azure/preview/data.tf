# Grabbing data from DMZ remote state file 
data "terraform_remote_state" "dmz_remote_state" {
  backend = "azurerm"

  config {
    storage_account_name = "woabelfasttfstate"
    container_name       = "woabelfast-tfstate"
    key                  = "dmz.terraform.tfstate"
    resource_group_name  = "tfstate_rg"
  }
}

# Grabbing data from AWS preview remote state file 
data "terraform_remote_state" "aws_preview_remote_state" {
  backend = "s3"
   config {
    bucket = "woa-belfast"
    key    = "preview/woa.tfstate"
    region = "eu-west-1"
  }
}

data "aws_route53_zone" "selected" {
    name = "woabelfast.co.uk"
  }
