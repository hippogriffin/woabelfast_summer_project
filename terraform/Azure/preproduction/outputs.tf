# Create output for dmz environment to use for vnet peering
output "preproduction_vnet_id" 
{
  value = "${azurerm_virtual_network.preproduction_vnet.id}"
}

output "azurerm_storage_share_url" 
{
  value = "${azurerm_storage_share.storage_share.url}"
}