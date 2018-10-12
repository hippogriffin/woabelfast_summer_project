#Security Groups for the preproduction Environment

# DB server
resource "azurerm_network_security_group" "preproduction_db_sg" {
  name                = "db_sg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  security_rule {
    name                       = "preproduction_db_ssh_sr"
    priority                   = 100                                                                   // this is the highest so may be subject to change
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = ["${var.kainos_ip}", "${var.azure_dmz_cidr}", "${var.aws_mgmt_cidr}"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "preproduction_db_mysql_sr"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "${var.preproduction_wordpress_cidr}"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "preproduction_db_sr"
    priority                   = 102             // this may be deleted
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
resource "azurerm_network_security_group" "preproduction_sg_lb" {
  name                = "preproduction_sg_lb"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

    security_rule {
    name                       = "port80_inbound"
    priority                   = 100 
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefixes = ["172.17.100.0/24","172.17.101.0/24"]
  }

    security_rule {
    name                       = "port443_inbound"
    priority                   = 101 
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefixes = ["172.17.100.0/24","172.17.101.0/24"]
  }

    # NSG ports
    security_rule {
    name                       = "nsg_port_inbound"
    priority                   = 102 
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "65503-65534"
    source_address_prefix      = "Internet"
    destination_address_prefixes = ["172.17.100.0/24","172.17.101.0/24"]
  }
}

# Wordpress server
resource "azurerm_network_security_group" "preproduction_wordpress_sg" {
  name                = "wordpress_sg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  security_rule {
    name                       = "preproduction_wp_shh_sr"
    priority                   = 100                                                                   // this is the highest so may be subject to change
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = ["${var.kainos_ip}", "${var.azure_dmz_cidr}", "${var.aws_mgmt_cidr}"] ## <<< JUMPBOX IP Required here
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "preproduction_wp_lb_sr"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "preproduction_wp_http_sr"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "${var.preproduction_proxy_cidr}"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "preproduction_wp_sr"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  tags {
    environment = "${var.environment}"
  }
}

# Web Servers
resource "azurerm_network_security_group" "preproduction_webservers_sg" {
  name                = "webservers_sg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  security_rule {
    name                       = "preproduction_proxy_shh_sr"
    priority                   = 100                                                                   // this is the highest so may be subject to change
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = ["${var.kainos_ip}", "${var.azure_dmz_cidr}", "${var.aws_mgmt_cidr}"] ## <<< JUMPBOX IP Required here
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "preproduction_proxy_https_sr"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefixes    = ["${var.kainos_ip}", "172.17.100.0/24", "172.17.101.0/24"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "preproduction_proxy_http_sr"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefixes    = ["${var.kainos_ip}", "172.17.100.0/24", "172.17.101.0/24"]
    destination_address_prefix = "*"
  }

  tags {
    environment = "${var.environment}"
  }
}