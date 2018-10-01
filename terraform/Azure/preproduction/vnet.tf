# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}_vnet"
  address_space       = ["${var.cidr}"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}
