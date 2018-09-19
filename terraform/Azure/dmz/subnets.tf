# Create subnet for jumpbox
resource "azurerm_subnet" "dmz_subnet" {
  name                 = "${var.dmz_subnet_name}"
  resource_group_name  = "${var.dmz_rg_name}"
  virtual_network_name = "${var.dmz_vnet_name}"
  address_prefix       = "172.16.1.0/24"
}

# Create subnet for VPN Client Configuration
resource "azurerm_subnet" "vpn_client_subnet" {
  name                 = "${var.vpn_client_subnet_name}"
  resource_group_name  = "${var.dmz_rg_name}"
  virtual_network_name = "${var.dmz_vnet_name}"
  address_prefix       = "${var.vpn_client_config}"
}