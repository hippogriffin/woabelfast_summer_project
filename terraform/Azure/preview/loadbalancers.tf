# External Load Balancer for Preview environment
resource "azurerm_lb" "preview_lb" {
  name                = "preview_loadbalancer"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = "${azurerm_public_ip.preview_publicip_lb.ip_address}"
  }
}