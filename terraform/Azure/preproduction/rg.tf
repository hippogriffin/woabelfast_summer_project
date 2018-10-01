# Resource group for the Preproduction Environment
resource "azurerm_resource_group" "preproduction_rg" {
  name     = "preproduction_rg"
  location = "${var.location}"
}
