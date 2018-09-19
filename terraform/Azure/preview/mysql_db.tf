resource "azurerm_mysql_server" "preview_mysql_server" {
  name                = "preview_server"
  location            = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"

  sku {
    name     = "B_Gen4_2"
    capacity = 2
    tier     = "Basic"
    family   = "Gen4"
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "wpuser"
  administrator_login_password = "123456789"
  version                      = "5.7"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_mysql_database" "preview_mysql_db" {
  name                = "preview_db"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"
  server_name         = "${azurerm_mysql_server.preview_mysql_server.name}"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_virtual_network_rule" "preview_mysql_vnet_rule" {
  name                = "preview_mysql_vnet_rule"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"
  server_name         = "${azurerm_mysql_server.preview_mysql_server.name}"
  subnet_id           = "${azurerm_subnet.preview_wordpress_subnet.id}"
}

resource "azurerm_mysql_firewall_rule" "preview_mysql_firewall_rule" {
  name                = "preview_mysql_firewall_rule"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"
  server_name         = "${azurerm_mysql_server.preview_mysql_server.name}"
  start_ip_address    = "${var.kainos_ip}"
  end_ip_address      = "${var.kainos_ip}"
}