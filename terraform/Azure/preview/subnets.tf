# Proxy Subnet
resource "azurerm_subnet" "preview_proxy_subnet" {
  name                 = "${var.environment}_proxy_subnet"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix       = "${var.preview_proxy_cidr}"
  network_security_group_id = "${azurerm_network_security_group.preview_webservers_sg.id}"

}

# Wordpress Subnet
resource "azurerm_subnet" "preview_wordpress_subnet" {
  name                 = "${var.environment}_wordpress_subnet"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix       = "${var.preview_wordpress_cidr}"
  service_endpoints    = ["Microsoft.Sql"]
  network_security_group_id = "${azurerm_network_security_group.preview_wordpress_sg.id}"
}

# DB Subnet
resource "azurerm_subnet" "preview_db_subnet" {
  name                 = "${var.environment}_db_subnet"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix       = "${var.preview_db_cidr}"
}

# Subnets for our external facing load balancer
resource "azurerm_subnet" "externallb_subnet_01" {
  name                      = "externallb_subnet_01"
  resource_group_name       = "${azurerm_resource_group.rg.name}"
  virtual_network_name      = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix            = "172.17.100.0/24"
  network_security_group_id = "${azurerm_network_security_group.preview_sg_lb.id}"
}

resource "azurerm_subnet" "externallb_subnet_02" {
  name                      = "externallb_subnet_02"
  resource_group_name       = "${azurerm_resource_group.rg.name}"
  virtual_network_name      = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix            = "172.17.101.0/24"
  network_security_group_id = "${azurerm_network_security_group.preview_sg_lb.id}"
}