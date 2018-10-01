# Proxy Subnet
resource "azurerm_subnet" "preproduction_proxy_subnet" {
  name                 = "${var.environment}_proxy_subnet"
  resource_group_name  = "${azurerm_resource_group.preproduction_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preproduction_vnet.name}"
  address_prefix       = "${var.preproduction_proxy_cidr}"
}

# Wordpress Subnet
resource "azurerm_subnet" "preproduction_wordpress_subnet" {
  name                 = "${var.environment}_wordpress_subnet"
  resource_group_name  = "${azurerm_resource_group.preproduction_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preproduction_vnet.name}"
  address_prefix       = "${var.preproduction_wordpress_cidr}"
  route_table_id       = "${azurerm_route_table.preproduction_route_table.id}"
  service_endpoints    = ["Microsoft.Sql"]
}

# DB Subnet
resource "azurerm_subnet" "preproduction_db_subnet" {
  name                 = "${var.environment}_db_subnet"
  resource_group_name  = "${azurerm_resource_group.preproduction_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preproduction_vnet.name}"
  address_prefix       = "${var.preproduction_db_cidr}"
}

# Subnets for our external facing load balancer
resource "azurerm_subnet" "externallb_subnet_01" {
  name                      = "externallb_subnet_01"
  resource_group_name       = "${azurerm_resource_group.preproduction_rg.name}"
  virtual_network_name      = "${azurerm_virtual_network.preproduction_vnet.name}"
  address_prefix            = "${var.externallb_subnet_01_ip}"
  network_security_group_id = "${azurerm_network_security_group.preproduction_sg_lb.id}"
}

resource "azurerm_subnet" "externallb_subnet_02" {
  name                      = "externallb_subnet_02"
  resource_group_name       = "${azurerm_resource_group.preproduction_rg.name}"
  virtual_network_name      = "${azurerm_virtual_network.preproduction_vnet.name}"
  address_prefix            = "${var.externallb_subnet_01_ip}" 
  network_security_group_id = "${azurerm_network_security_group.preproduction_sg_lb.id}"
}