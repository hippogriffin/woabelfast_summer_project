resource "azurerm_virtual_machine" "preview-proxy" {
  name                  = "${var.proxy_server_name}"
  location              = "${azurerm_resource_group.preview_rg.location}"
  availability_set_id = "${azurerm_availability_set.proxy_avset.id}"
  resource_group_name   = "${azurerm_resource_group.preview_rg.name}"
  network_interface_ids = ["${azurerm_network_interface.preview-proxy.id}"]
  vm_size               = "${var.proxy_vm_size}"

resource "azurerm_network_interface" "preview-proxy" {
    name                = "${var.proxy_server_name}-nic"
    location            = "${azurerm_resource_group.preview_rg.location}"
    resource_group_name = "${azurerm_resource_group.preview_rg.name}"

  ip_configuration {
    name                          = "preview_proxy_ip"
    subnet_id                     = "${azurerm_subnet.preview_subnet.id}"
    private_ip_address_allocation = "dynamic"
  }
}

  storage_image_reference {
    publisher = "${var.proxy_storage_image_reference.[publisher]}"
    offer     = "${var.proxy_storage_image_reference.[offer]}"
    sku       = "${var.proxy_storage_image_reference.[sku]}"
    version   = "${var.proxy_storage_image_reference.[version]}"
  }

  storage_os_disk {
    name              = "${var.proxy_storage_os_disk.[name]}"
    caching           = "${var.proxy_storage_os_disk.[caching]}"
    create_option     = "${var.proxy_storage_os_disk.[create_option]}"
    managed_disk_type = "${var.proxy_storage_os_disk.[managed_disk_type]}"
  }

  os_profile {
    computer_name  = "${var.proxy_os_profile.[computer_name]}"
    admin_username = "${var.proxy_os_profile.[admin_username]}"
    admin_password = "${var.proxy_os_profile.[admin_password]}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags {
    environment = "${var.environment}"
  }
}