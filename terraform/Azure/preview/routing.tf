resource "azurerm_route_table" "preview_route_table" {
  name                = "preview_route_table"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

route {
    name = "azure_to_aws_jenkins_route"
    address_prefix = "10.121.0.0/16"
    next_hop_type = "VirtualNetworkGateway"
  }
}