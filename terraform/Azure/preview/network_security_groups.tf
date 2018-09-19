#Security Groups for the Preview Environment

# DB server
resource "azurerm_network_security_group" "preview_db_sg" {
  name                = "db_sg"
  location            = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"

  security_rule {
    name                       = "preview_db_ssh_sr"
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
    name                       = "preview_db_mysql_sr"
    priority                   = 101 
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "3306"
    destination_port_range     = "3306"
    source_address_prefix      = "${var.kainos_ip}"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "preview_db_sr"
    priority                   = 102 // this may be deleted
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags {
    environment = "${var.environment}"
  }
}


# Network security group for public loadbalancer
resource "azurerm_network_security_group" "preview_sg_lb" {
  name                = "${azurerm_network_security_group.preview_sg_lb.name}"
  location            = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"

    security_rule {
    name                       = "port80_inbound"
    priority                   = 100 
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "80"
    destination_port_range     = "80"
    source_address_prefix      = "${var.kainos_ip}"
    destination_address_prefixes = ["172.17.100.0/24","172.17.101.0/24"]
  }

    security_rule {
    name                       = "port443_inbound"
    priority                   = 101 
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "443"
    destination_port_range     = "443"
    source_address_prefix      = "${var.kainos_ip}"
    destination_address_prefix = ["172.17.100.0/24","172.17.101.0/24"]
  }

}

# Wordpress server
resource "azurerm_network_security_group" "preview_wordpress_sg" {
  name                = "wordpress_sg"
  location            = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"

  security_rule {
    name                       = "preview_wp_shh_sr"
    priority                   = 100 // this is the highest so may be subject to change
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = "${var.kainos_ip}" ## <<< JUMPBOX IP Required here
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "preview_wp_http_sr"
    priority                   = 101 // this is the highest so may be subject to change
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "80"
    destination_port_range     = "80"
    source_address_prefix      = "${var.kainos_ip}"
    destination_address_prefix = "*"
  }

  tags {
    environment = "${var.environment}"
  }
}

