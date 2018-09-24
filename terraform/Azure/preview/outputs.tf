# Create output for dmz environment to use for vnet peering
output "preview_vnet_id" 
{
  value = "${azurerm_virtual_network.preview_vnet.id}"
}

output "azurerm_storage_share_url" 
{
  value = "${azurerm_storage_share.storage_share.url}"
}

# Create output for the azure agw load balancer ip to be used in AWS
output "azure_app_gw_ip" 
{
  value = "${azurerm_public_ip.preview_app_gw_public_ip.id}"
}