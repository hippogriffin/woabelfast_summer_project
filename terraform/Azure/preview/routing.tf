resource "azurerm_route_table" "preview_route_table" {
  name                = "preview_route_table"
  location            = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"
}