resource "azurerm_lb" "loadbalancer" {
  name                = "${var.environment}LoadBalancer"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

    frontend_ip_configuration {
    name                          = "${var.environment}_lb_public_ip"
    private_ip_address            = "172.17.2.255"
    private_ip_address_allocation = "static"
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
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.environment}_lb_public_ip"
}

resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = "${azurerm_resource_group.rg.name}"
  loadbalancer_id     = "${azurerm_lb.loadbalancer.id}"
  protocol            = "http"
  name                = "${var.environment}_lb_probe"
  port                = 80
  request_path        = "/elb_status" // Required if protocol is set to Http. Otherwise, it is not allowed
}