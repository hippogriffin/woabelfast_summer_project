# Resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.environment}_rg"
  location = "${var.location}"
}