data "azurerm_network_security_group" "preview_sg_01" {
  name                = "${azurerm_network_security_group.test.name}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"
}

data "azurerm_network_security_group" "preview_sg_02" {
  name                = "${azurerm_network_security_group.test.name}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"
}
