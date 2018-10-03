# Create output for dmz environment to use for vnet peering
output "vnet_id" 
{
  value = "${azurerm_virtual_network.vnet.id}"
}

output "azurerm_storage_share_url" 
{
  value = "${azurerm_storage_share.storage_share.url}"
}