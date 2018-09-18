# Preview Subnet

resource "azurerm_subnet" "preview_subnet" {
  name                 = "preview_subnet"
  resource_group_name  = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix       = "${var.preview_cidr}"
  route_table_id       = "${azurerm_route_table.preview_route_table.id}"
}

# Proxy Subnet
resource "azurerm_subnet" "preview_proxy_subnet" {
  name                 = "preview_proxy_subnet"
  resource_group_name  = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix       = "${var.preview_proxy_cidr}"
  route_table_id       = "${azurerm_route_table.preview_route_table.id}"
}

# Wordpress Subnet
resource "azurerm_subnet" "preview_wordpress_subnet" {
  name                 = "preview_wordpress_subnet"
  resource_group_name  = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix       = "${var.preview_wordpress_cidr}"
  route_table_id       = "${azurerm_route_table.preview_route_table.id}"
}

# DB Subnet
resource "azurerm_subnet" "preview_db_subnet" {
  name                 = "preview_db_subnet"
  resource_group_name  = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix       = "${var.preview_db_cidr}"
  route_table_id       = "${azurerm_route_table.preview_route_table.id}"
}

# Subnets for our external facing load balancer
resource "azurerm_subnet" "externallb_subnet_01" {
  name                      = "externallb_subnet_01"
  resource_group_name       = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name      = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix            = "172.17.100.0/24"
  network_security_group_id = "${azurerm_network_security_group.preview_sg_lb.id}"
}

resource "azurerm_subnet" "externallb_subnet_02" {
  name                      = "externallb_subnet_02"
  resource_group_name       = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name      = "${azurerm_virtual_network.preview_vnet.name}"
  address_prefix            = "172.17.101.0/24"
  network_security_group_id = "${azurerm_network_security_group.preview_sg_lb.id}"
}
