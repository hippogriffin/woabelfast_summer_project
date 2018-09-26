# Remote State Backend
data "terraform_remote_state" "preview_remote_state" {
  backend = "azurerm"

  config {
    storage_account_name = "woabelfasttfstate"
    container_name       = "woabelfast-tfstate"
    key                  = "preview.terraform.tfstate"
    resource_group_name  = "tfstate_rg"
  }
}
