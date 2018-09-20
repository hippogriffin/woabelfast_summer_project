# Create subnet for jumpbox
resource "azurerm_subnet" "dmz_subnet" {
  name                 = "${var.dmz_subnet_name}"
  resource_group_name  = "${azurerm_resource_group.dmz_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.dmz_vnet.name}"
  address_prefix       = "172.16.1.0/24"
}

# Create subnet for VPN GW
resource "azurerm_subnet" "vpn_gw_subnet" {
  name                 = "${var.vpn_gw_subnet_name}"
  resource_group_name  = "${azurerm_resource_group.dmz_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.dmz_vnet.name}"
  address_prefix       = "${var.vpn_gw_config}"
}

# Create subnet for VPN Client Configuration
#resource "azurerm_subnet" "vpn_client_subnet" {
#  name                 = "${var.vpn_client_subnet_name}"
# resource_group_name  = "${azurerm_resource_group.dmz_rg.name}"
#  virtual_network_name = "${azurerm_virtual_network.dmz_vnet.name}"
#  address_prefix       = "${var.vpn_client_config}"
#}