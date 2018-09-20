# Create output for preview environment to use for vnet peering
output "dmz_rg_id" 
{
  value = "${basename(azurerm_resource_group.dmz_rg.id)}"
}

output "dmz_vnet_id" 
{
  value = "${basename(azurerm_virtual_network.dmz_vnet.id)}"
}