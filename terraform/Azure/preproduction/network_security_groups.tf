# Security Groups

# DB server
resource "azurerm_network_security_group" "db_sg" {
  name                = "db_sg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  security_rule {
    name                       = "${var.environment}_db_ssh_sr"
    priority                   = 100 // this is the highest so may be subject to change
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefixes      = ["${var.kainos_ip}", "${var.azure_dmz_cidr}", "${var.aws_mgmt_cidr}"]
    destination_address_prefix = "*"
  }

   security_rule {
    name                       = "${var.environment}_db_mysql_sr"
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
    name                       = "${var.environment}_db_sr"
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
resource "azurerm_network_security_group" "sg_lb" {
  name                = "${var.environment}_sg_lb"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

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
    destination_address_prefixes = ["172.17.100.0/24","172.17.101.0/24"]
  }

}

# Wordpress server
resource "azurerm_network_security_group" "wordpress_sg" {
  name                = "wordpress_sg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  security_rule {
    name                       = "${var.environment}_wp_shh_sr"
    priority                   = 100 // this is the highest so may be subject to change
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefixes      = ["${var.kainos_ip}", "${var.azure_dmz_cidr}", "${var.aws_mgmt_cidr}"] ## <<< JUMPBOX IP Required here
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "${var.environment}_wp_http_sr"
    priority                   = 101
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

# Web Servers
resource "azurerm_network_security_group" "webservers_sg" {
  name                = "webservers_sg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  
  security_rule {
    name                       = "${var.environment}_proxy_shh_sr"
    priority                   = 100 // this is the highest so may be subject to change
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefixes      = ["${var.kainos_ip}", "${var.azure_dmz_cidr}", "${var.aws_mgmt_cidr}"] ## <<< JUMPBOX IP Required here
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "${var.environment}_proxy_https_sr"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "443"
    destination_port_range     = "443"
    source_address_prefix      = "${var.kainos_ip}"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "${var.environment}_proxy_http_sr"
    priority                   = 102
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