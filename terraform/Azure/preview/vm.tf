
resource "azurerm_virtual_machine" "wordpress" {
  name                  = "${format("${local.preview_wordpress_name}", count.index + 3)}"
  count                 = "${var.count}"
  location              = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name   = "${azurerm_resource_group.preview_rg.name}"
  network_interface_ids = ["${element(azurerm_network_interface.preview_wordpress_nic.*.id, count.index + 3)}"]
  availability_set_id = "${azurerm_availability_set.wordpress_avset.id}"
  vm_size               = "${var.wordpress_vm_size}"

storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7-CI"
    version   = "latest"
}

storage_os_disk {
    name              = "${format("${local.preview_wordpress_webserver_os_disk}", count.index + 3)}"
    caching           = "${lookup(var.wordpress_storage_os_disk, "caching")}"
    create_option     = "${lookup(var.wordpress_storage_os_disk, "create_option")}"
    managed_disk_type = "${lookup(var.wordpress_storage_os_disk, "managed_disk_type")}"
  }

os_profile {
    computer_name  = "${format("wordpress-vm-%02d", count.index + 3)}"
    admin_username = "${lookup(var.proxy_os_profile, "admin_username")}"
  }

   os_profile_linux_config {
    disable_password_authentication = true
     ssh_keys {
            path     = "/home/deploymentuser/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgYMNcDJKpkuXKaGsa2P9bZ0WTaB0H6iXvRNg0KCOD9DHTK9ljPLdETs5S2RNS/2aoLqsoVkR+3Sd1POYg9YVlOf9SYMjIQM3CYQkFW9ExfnlbOao6NlyJJXV9vLOu1lAIlMT7/UIU/6wdU4BgdIJW7WU9inY4R+j+5ss/tt/pkbYkh74mQf20Zj93ugXPaY87dz5Ij3SRYnpERjTo25Prdc75B4RG/2L3p5KNvD/OKUOkNZBSlH0tlo1hjQLa3DIaHZHu50XTpabFibBOjMC5MPCUp/WSNG5JXqiEJO+6wwFQW1uOQVxlviARr6sCZID5b6eJ8ElQEQ5HFH8ku+3x woabelfast_rsa_key"
        }
    
  }

}

resource "azurerm_network_interface" "preview_wordpress_nic" {
  name                = "${format("${local.preview_wordpress_nic_name}", count.index + 3)}"
  count               = "${var.count}"
  location            = "${azurerm_resource_group.preview_rg.location}"
  resource_group_name = "${azurerm_resource_group.preview_rg.name}"
  network_security_group_id = "${azurerm_network_security_group.preview_sg_lb.id}"

  ip_configuration {
    name                          = "${format("${local.wordpress_ip_name}", count.index + 3)}"
    subnet_id                     = "${azurerm_subnet.preview_wordpress_subnet.id}"
    private_ip_address_allocation = "dynamic"
  }

  tags {
    environment = "preview"
  }
}


resource "azurerm_network_interface" "preview-proxy" {
    name                = "${format("${local.proxy_nic_name}", count.index + 3)}"
    count               = "${var.count}"
    location            = "${azurerm_resource_group.preview_rg.location}"
    resource_group_name = "${azurerm_resource_group.preview_rg.name}"
    network_security_group_id = "${azurerm_network_security_group.preview_sg_lb.id}"

  ip_configuration {
    name                          = "${format("${local.proxy_ip_name}", count.index + 3)}"
    subnet_id                     = "${azurerm_subnet.preview_proxy_subnet.id}"
    private_ip_address_allocation = "dynamic"
  }
}
resource "azurerm_virtual_machine" "preview-proxy" {
  name                  = "${format("${local.preview_webserver_names}", count.index + 3)}"
  count                 = "${var.count}"
  location              = "${azurerm_resource_group.preview_rg.location}"
  availability_set_id = "${azurerm_availability_set.proxy_avset.id}"
  resource_group_name   = "${azurerm_resource_group.preview_rg.name}"
  network_interface_ids = ["${element(azurerm_network_interface.preview-proxy.*.id, count.index + 3)}"]
  vm_size               = "${var.proxy_vm_size}"

  storage_image_reference {
    publisher = "${lookup(var.proxy_storage_image_reference, "publisher")}"
    offer     = "${lookup(var.proxy_storage_image_reference, "offer")}"
    sku       = "${lookup(var.proxy_storage_image_reference, "sku")}"
    version   = "${lookup(var.proxy_storage_image_reference, "version")}"
  }

  storage_os_disk {
    name              = "${format("${local.preview_webserver_os_disk}", count.index + 3)}"
    caching           = "${lookup(var.proxy_storage_os_disk, "caching")}"
    create_option     = "${lookup(var.proxy_storage_os_disk, "create_option")}"
    managed_disk_type = "${lookup(var.proxy_storage_os_disk, "managed_disk_type")}"
  }

  os_profile {
    computer_name  = "${format("${local.preview_webserver_names}", count.index + 3)}"
    admin_username = "${lookup(var.proxy_os_profile, "admin_username")}"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
            path     = "/home/deploymentuser/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgYMNcDJKpkuXKaGsa2P9bZ0WTaB0H6iXvRNg0KCOD9DHTK9ljPLdETs5S2RNS/2aoLqsoVkR+3Sd1POYg9YVlOf9SYMjIQM3CYQkFW9ExfnlbOao6NlyJJXV9vLOu1lAIlMT7/UIU/6wdU4BgdIJW7WU9inY4R+j+5ss/tt/pkbYkh74mQf20Zj93ugXPaY87dz5Ij3SRYnpERjTo25Prdc75B4RG/2L3p5KNvD/OKUOkNZBSlH0tlo1hjQLa3DIaHZHu50XTpabFibBOjMC5MPCUp/WSNG5JXqiEJO+6wwFQW1uOQVxlviARr6sCZID5b6eJ8ElQEQ5HFH8ku+3x woabelfast_rsa_key"
        }
  }

  tags {
    environment = "${var.environment}"
  }
}

