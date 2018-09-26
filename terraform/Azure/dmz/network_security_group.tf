
resource "azurerm_network_security_group" "dmz" {
  name                = "dmz_sg"
  location            = "${azurerm_resource_group.dmz_rg.location}"
  resource_group_name = "${azurerm_resource_group.dmz_rg.name}"

  security_rule {
    name                       = "dmz_sr"
    priority                   = 100 // this is the highest so may be subject to change
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = "${var.kainos_ip}"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "preview_aws_vpn_sr"
    priority                   = 108 // this is the highest so may be subject to change
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = "118.202.142.67" 
    destination_address_prefix = "Internet"
  }

    security_rule {
    name                       = "preview_aws_vpn_sr2"
    priority                   = 109 // this is the highest so may be subject to change
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = "118.202.142.67" 
    destination_address_prefix = "*"
  }


  tags {
    environment = "DMZ"
  }
}
