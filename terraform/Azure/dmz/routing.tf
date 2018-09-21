 resource "azurerm_route_table" "dmz_route_table" {
  name                = "DMZ Route Table"
  location            = "${azurerm_resource_group.dmz_rg.location}"
  resource_group_name = "${azurerm_resource_group.dmz_rg.name}"

route {
    name = "azure_to_aws_jenkins_route"
    address_prefix = "10.121.0.0/16"
    next_hop_type = "VirtualNetworkGateway"
  }
 }