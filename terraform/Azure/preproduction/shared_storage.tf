# Create storage account
resource "azurerm_storage_account" "shared_storage" {
  name                     = "preprodwoastorageacc"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create shared storage for Wordpress servers
resource "azurerm_storage_share" "storage_share" {
  name = "azure-storage-share"

  resource_group_name  = "${azurerm_resource_group.rg.name}"
  storage_account_name = "${azurerm_storage_account.shared_storage.name}"

  quota = 50
}