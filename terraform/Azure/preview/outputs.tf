# Create output for dmz environment to use for vnet peering
output "preview_vnet_id" 
{
  value = "${azurerm_virtual_network.preview_vnet.id}"
}