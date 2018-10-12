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

data "aws_route53_zone" "selected" {
    name = "woabelfast.co.uk"
  }

data "azurerm_public_ip" "preproduction_app_gw_ip" {
    resource_group_name = "${azurerm_application_gateway.preproduction_app_gw.resource_group_name}"
    name = "${azurerm_public_ip.preproduction_app_gw_public_ip.name}"
}
