resource "azurerm_availability_set" "proxy_avset" {
  name                = "${var.proxy_avset}"
  location            = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"

  tags {
    environment = "Preview"
  }
}