# Remote State Backend
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate_rg"
    storage_account_name = "woabelfasttfstate"
    container_name       = "woabelfast-tfstate"
    key                  = "preproduction.terraform.tfstate"
  }
}