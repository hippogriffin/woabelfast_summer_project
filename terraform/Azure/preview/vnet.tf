# Virtual Network for the Preview Environment
resource "azurerm_virtual_network" "preview_vnet" {
  name                = "${var.environment}_vnet"
  address_space       = ["${var.preview_cidr}"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"
}
