# Peering connection - Preview to DMZ
resource "azurerm_virtual_network_peering" "peering_preview_to_dmz" {
  name                         = "peer-preview-dmz"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  virtual_network_name         = "${azurerm_virtual_network.preview_vnet.name}"
  remote_virtual_network_id    = "${data.terraform_remote_state.dmz_remote_state.dmz_vnet_id}"
  use_remote_gateways          = true
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}

# Peering connection - DMZ to Preview
resource "azurerm_virtual_network_peering" "peering_dmz_to_preview" {
  name                         = "peer-dmz-preview"
  resource_group_name          = "${data.terraform_remote_state.dmz_remote_state.dmz_rg_name}"
  virtual_network_name         = "${data.terraform_remote_state.dmz_remote_state.dmz_vnet_name}"
  remote_virtual_network_id    = "${azurerm_virtual_network.preview_vnet.id}"
  allow_gateway_transit        = true
  allow_virtual_network_access = true
}
