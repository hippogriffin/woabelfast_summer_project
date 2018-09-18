resource "azurerm_virtual_network" "dmz_vnet" {
  name          = "${var.dmz_vnet_name}"
  resource_group_name  = "${var.dmz_rg_name}"
  address_space = ["${var.dmz_vnet_address_space}"]
  location      = "${var.location}"
}