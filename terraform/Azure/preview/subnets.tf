# Subnets for our external facing load balancer
resource "azurerm_subnet" "externallb_subnet_01" {
  name                 = "externallb_subnet_01"
  resource_group_name  = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix       = "172.17.100.0/24"
  network_security_group_id = "${azurerm_network_security_group.preview_sg_lb.id}"
}

resource "azurerm_subnet" "externallb_subnet_02" {
  name                 = "externallb_subnet_02"
  resource_group_name  = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix       = "172.17.101.0/24"
  network_security_group_id = "${azurerm_network_security_group.preview_sg_lb.id}"
}

