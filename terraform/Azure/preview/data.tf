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
