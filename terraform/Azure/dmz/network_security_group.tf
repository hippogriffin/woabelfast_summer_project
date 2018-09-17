
resource "azurerm_network_security_group" "dmz" {
  name                = "dmz_sg"
  location            = "${azurerm_resource_group.DMZ.location}"
  resource_group_name = "${azurerm_resource_group.DMZ.name}"

  security_rule {
    name                       = "dmz_sr"
    priority                   = 100 // this is the highest so may be subject to change
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = "195.89.171.5"
    destination_address_prefix = "*"
  }

  tags {
    environment = "DMZ"
  }
}
