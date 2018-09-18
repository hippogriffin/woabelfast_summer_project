# Create subnet for jumpbox
resource "azurerm_subnet" "dmz_subnet" {
  name                 = "${var.dmz_subnet_name}"
  resource_group_name  = "${var.dmz_rg_name}"
  virtual_network_name = "${var.dmz_vnet_name}"
  address_prefix       = "172.16.0.0/16"
}

