# Virtual Network for the Preproduction Environment
resource "azurerm_virtual_network" "preproduction_vnet" {
  name                = "${var.environment}_vnet"
  address_space       = ["${var.preproduction_cidr}"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}
