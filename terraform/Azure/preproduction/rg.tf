# Resource group for the Preproduction Environment
resource "azurerm_resource_group" "rg" {
  name     = "${var.environment}_rg"
  location = "${var.location}"
}