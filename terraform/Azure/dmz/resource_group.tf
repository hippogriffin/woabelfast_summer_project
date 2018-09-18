# DMZ resource group 
resource "azurerm_resource_group" "dmz_rg" {
  name     = "${var.dmz_rg_name}"
  location = "${var.location}"
}