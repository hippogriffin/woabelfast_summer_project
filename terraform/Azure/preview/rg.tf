# Resource group for the Preview Environment
resource "azurerm_resource_group" "preview_rg" {
  name     = "preview_rg"
  location = "${var.location}"
}
