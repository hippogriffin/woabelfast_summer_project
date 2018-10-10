resource "azurerm_public_ip" "preview_app_gw_public_ip" {
  name                         = "${var.environment}_app_gw_public_ip"
  location                     = "${azurerm_resource_group.rg.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation = "dynamic"
}

# Create an application gateway/loadbalancer
resource "azurerm_application_gateway" "preview_app_gw" {
  name                = "${var.environment}_app_gw"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${var.location}"

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "${var.environment}_gw_ip_config"
    subnet_id = "${azurerm_virtual_network.preview_vnet.id}/subnets/${azurerm_subnet.externallb_subnet_01.name}"
  }

  frontend_port {
    name = "${azurerm_virtual_network.preview_vnet.name}-http-feport" ## http
    port = 80
  }

  frontend_port {
    name = "${azurerm_virtual_network.preview_vnet.name}-feport" ## https
    port = 443
  }

  frontend_ip_configuration {
    name                 = "${azurerm_virtual_network.preview_vnet.name}-feip"
    public_ip_address_id = "${azurerm_public_ip.preview_app_gw_public_ip.id}"
  }

  backend_address_pool {
    name            = "${azurerm_virtual_network.preview_vnet.name}-beap"
    ip_address_list = ["${azurerm_network_interface.preview-proxy.*.private_ip_address}"]
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.preview_vnet.name}-be-htst"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
    probe_name            = "${azurerm_virtual_network.preview_vnet.name}-probe"
  }

  http_listener {
    name                           = "${azurerm_virtual_network.preview_vnet.name}-httplstn"
    frontend_ip_configuration_name = "${azurerm_virtual_network.preview_vnet.name}-feip"
    frontend_port_name             = "${azurerm_virtual_network.preview_vnet.name}-http-feport"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "${azurerm_virtual_network.preview_vnet.name}-httpslstn"
    frontend_ip_configuration_name = "${azurerm_virtual_network.preview_vnet.name}-feip"
    frontend_port_name             = "${azurerm_virtual_network.preview_vnet.name}-feport"
    protocol                       = "Https"
    ssl_certificate_name           = "${azurerm_virtual_network.preview_vnet.name}-cert"
  }

  request_routing_rule {
    name                       = "${azurerm_virtual_network.preview_vnet.name}-rqrt"
    rule_type                  = "Basic"
    http_listener_name         = "${azurerm_virtual_network.preview_vnet.name}-httplstn"
    backend_address_pool_name  = "${azurerm_virtual_network.preview_vnet.name}-beap"
    backend_http_settings_name = "${azurerm_virtual_network.preview_vnet.name}-be-htst"
  }

   request_routing_rule {
    name                       = "${azurerm_virtual_network.preview_vnet.name}-rqrt2"
    rule_type                  = "Basic"
    http_listener_name         = "${azurerm_virtual_network.preview_vnet.name}-httpslstn"
    backend_address_pool_name  = "${azurerm_virtual_network.preview_vnet.name}-beap"
    backend_http_settings_name = "${azurerm_virtual_network.preview_vnet.name}-be-htst"
  }

  probe {
    name                = "${azurerm_virtual_network.preview_vnet.name}-probe"
    protocol            = "Http"
    path                = "/elb_status"
    host                = "127.0.0.1"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
  }

  ssl_certificate {
    name     = "${azurerm_virtual_network.preview_vnet.name}-cert"
    data     = "${base64encode(file("preview.woabelfast.co.uk.pfx"))}"
    password = "password"
  }
}
