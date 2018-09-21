# Create output for preview environment to use for vnet peering
output "dmz_rg_name" 
{
  value = "${azurerm_resource_group.dmz_rg.name}"
}

output "dmz_vnet_id" 
{
  value = "${azurerm_virtual_network.dmz_vnet.id}"
}

output "dmz_vnet_name" 
{
  value = "${azurerm_virtual_network.dmz_vnet.name}"
}

output "dmz_vnet_gw_id" 
{
  value = "${azurerm_virtual_network_gateway.dmz_vnet_gw.id}"
}
