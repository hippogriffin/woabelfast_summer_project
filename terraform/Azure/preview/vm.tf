resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name   = "${azurerm_resource_group.preview_rg.name}"
  network_interface_ids = ["${azurerm_network_interface.preview_nic.id}"]
  vm_size               = "Standard_DS1_v2"

storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.4"
    version   = "latest"
}

storage_os_disk {
    name              = "os_storage_1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

 os_profile_linux_config {
    disable_password_authentication = false
     ssh_keys {
            path     = "/home/azureuser/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgYMNcDJKpkuXKaGsa2P9bZ0WTaB0H6iXvRNg0KCOD9DHTK9ljPLdETs5S2RNS/2aoLqsoVkR+3Sd1POYg9YVlOf9SYMjIQM3CYQkFW9ExfnlbOao6NlyJJXV9vLOu1lAIlMT7/UIU/6wdU4BgdIJW7WU9inY4R+j+5ss/tt/pkbYkh74mQf20Zj93ugXPaY87dz5Ij3SRYnpERjTo25Prdc75B4RG/2L3p5KNvD/OKUOkNZBSlH0tlo1hjQLa3DIaHZHu50XTpabFibBOjMC5MPCUp/WSNG5JXqiEJO+6wwFQW1uOQVxlviARr6sCZID5b6eJ8ElQEQ5HFH8ku+3x woabelfast_rsa_key"
        }
  }


}

resource "azurerm_network_interface" "preview_nic" {
  name                = "NetworkInterfacePreview"
  location            = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.preview_wordpress_subnet.id}"
    private_ip_address_allocation = "dynamic"
  }

  tags {
    environment = "preview"
  }
}

