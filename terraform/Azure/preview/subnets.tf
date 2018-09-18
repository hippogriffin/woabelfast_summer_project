# Preview Subnet

resource "azurerm_subnet" "preview_subnet" {
  name                 = "preview_subnet"
  resource_group_name  = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.private_vnet.name}"
  address_prefix       = "${var.preview_cidr}"
  route_table_id       = "${azurerm_route_table.preview_route_table.id}"
}

# Proxy Subnet
resource "azurerm_subnet" "preview_proxy_subnet" {
  name                 = "preview_proxy_subnet"
  resource_group_name  = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.private_vnet.name}"
  address_prefix       = "${var.preview_proxy_cidr}"
  route_table_id       = "${azurerm_route_table.preview_route_table.id}"
}

# Wordpress Subnet
resource "azurerm_subnet" "preview_wordpress_subnet" {
  name                 = "preview_wordpress_subnet"
  resource_group_name  = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.private_vnet.name}"
  address_prefix       = "${var.preview_wordpress_cidr}"
  route_table_id       = "${azurerm_route_table.preview_route_table.id}"
}

# DB Subnet
resource "azurerm_subnet" "preview_db_subnet" {
  name                 = "preview_db_subnet"
  resource_group_name  = "${azurerm_resource_group.preview_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.private_vnet.name}"
  address_prefix       = "${var.preview_db_cidr}"
  route_table_id       = "${azurerm_route_table.preview_route_table.id}"
}
