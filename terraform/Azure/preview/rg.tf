# Resource group for the Preview Environment
resource "azurerm_resource_group" "preview_rg" {
  name     = "preview_rg"
  location = "${var.location}"
}

resource "azurerm_public_ip" "preview_publicip_lb" {
  name                         = "preview_publicip_lb"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.preview_rg.name}"
  public_ip_address_allocation = "static"
}