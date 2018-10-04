resource "azurerm_lb" "loadbalancer" {
  name                = "${var.environment}LoadBalancer"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

    frontend_ip_configuration {
    name                  = "${var.environment}_lb_public_ip"
    private_ip_address_id = "dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "lb_beap" {
  resource_group_name = "${azurerm_resource_group.rg.name}"
  loadbalancer_id     = "${azurerm_lb.loadbalancer.id}"
  name                = "${var.location}_BackEndAddressPool"
}

resource "azurerm_lb_rule" "lb_rule" {
  resource_group_name            = "${azurerm_resource_group.rg.name}"
  loadbalancer_id                = "${azurerm_lb.loadbalancer.id}"
  name                           = "${var.environment}_lb_rule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "${var.environment}_lb_public_ip"
}

resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = "${azurerm_resource_group.rg.name}"
  loadbalancer_id     = "${azurerm_lb.loadbalancer.id}"
  name                = "${var.environment}_lb_probe"
  port                = 22
}