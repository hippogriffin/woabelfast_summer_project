resource "azurerm_local_network_gateway" "dmz_local_network_gw" {
  name                = "dmz_local_network_gw"
  resource_group_name = "${azurerm_resource_group.dmz_rg.name}"
  location            = "${azurerm_resource_group.dmz_rg.location}"
  gateway_address     = "${var.aws_strongswan}"
  address_space       = ["${var.aws_dmz_cidr}"] 
}

resource "azurerm_public_ip" "dmz_public_ip" {
  name                = "dmz_public_ip"
  location            = "${azurerm_resource_group.dmz_rg.location}"
  resource_group_name = "${azurerm_resource_group.dmz_rg.name}"

  public_ip_address_allocation = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "dmz_vnet_gw" {
  name                = "dmz_vnet_gw"
  location            = "${azurerm_resource_group.dmz_rg.location}"
  resource_group_name = "${azurerm_resource_group.dmz_rg.name}"

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = "${azurerm_public_ip.dmz_public_ip.id}"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "${azurerm_subnet.vpn_gw_subnet.id}"
  }
}