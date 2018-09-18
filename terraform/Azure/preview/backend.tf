# Remote State Backend
terraform {
  backend "azurerm" {
    storage_account_name = "woabelfasttfstate"
    resource_group_name  = "tfstate_rg"
    container_name       = "woabelfast-tfstate"
    key                  = "preview.woabelfast.tfstate"
  }
}