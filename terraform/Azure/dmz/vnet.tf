resource "azurerm_virtual_network" "dmz_vnet" {
  name                 = "${var.dmz_vnet_name}"
  resource_group_name  = "${azurerm_resource_group.dmz_rg.name}"
  address_space        = ["${var.dmz_vnet_address_space}"]
  location             = "${var.location}"
}