resource "azurerm_availability_set" "proxy_avset" {
  name                = "${var.proxy_avset}"
  location            = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"
  platform_fault_domain_count = 2
  managed = true

  tags {
    environment = "Preview"
  }
}

resource "azurerm_availability_set" "wordpress_avset" {
  name                = "${var.wordpress_avset}"
  location            = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"
  platform_fault_domain_count = 2
  managed = true

  tags {
    environment = "Preview"
  }
}