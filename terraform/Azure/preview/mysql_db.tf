resource "azurerm_mysql_server" "preview_mysql_server" {
  name                         = "preview-mysql-server"
  location                     = "${azurerm_resource_group.rg.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  administrator_login          = "wpuser"
  administrator_login_password = "Password123"
  version                      = "5.7"
  ssl_enforcement              = "Disabled"

  sku {
    name     = "GP_Gen5_2"
    capacity = 2
    tier     = "GeneralPurpose"
    family   = "Gen5"
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }
}

resource "azurerm_mysql_database" "preview_mysql_db" {
  name                = "preview_db"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  server_name         = "${azurerm_mysql_server.preview_mysql_server.name}"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_virtual_network_rule" "preview_mysql_vnet_rule" {
  name                = "preview-mysql-vnet-rule"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  server_name         = "${azurerm_mysql_server.preview_mysql_server.name}"
  subnet_id           = "${azurerm_subnet.preview_wordpress_subnet.id}"
}

resource "azurerm_mysql_firewall_rule" "preview_mysql_firewall_rule" {
  name                = "preview_mysql_firewall_rule"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  server_name         = "${azurerm_mysql_server.preview_mysql_server.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}