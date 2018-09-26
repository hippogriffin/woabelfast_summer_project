# Create network interface
resource "azurerm_network_interface" "jumpbox-nic" {
  name                            = "${var.nic_name}"
  location                        = "${azurerm_resource_group.dmz_rg.location}"
  resource_group_name             = "${azurerm_resource_group.dmz_rg.name}"

  ip_configuration {
    name                          = "testconfiguration"
    subnet_id                     = "${azurerm_subnet.dmz_subnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${azurerm_public_ip.jumpbox_public_ip.id}"
  }
}

# Create jumpbox instance
resource "azurerm_virtual_machine" "jumpbox" {
  name                  = "${var.dmz_jumpbox_name}"
  location              = "${azurerm_resource_group.dmz_rg.location}"
  resource_group_name   = "${azurerm_resource_group.dmz_rg.name}"
  network_interface_ids = ["${azurerm_network_interface.jumpbox-nic.id}"]
  vm_size               = "Standard_DS1_v2"


  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"
  }

  storage_os_disk {
    name              = "jumpbox_os_disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "jumpbox-vm"
    admin_username = "deploymentuser"
  }

   os_profile_linux_config {
    disable_password_authentication = true
     ssh_keys {
            path     = "/home/deploymentuser/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgYMNcDJKpkuXKaGsa2P9bZ0WTaB0H6iXvRNg0KCOD9DHTK9ljPLdETs5S2RNS/2aoLqsoVkR+3Sd1POYg9YVlOf9SYMjIQM3CYQkFW9ExfnlbOao6NlyJJXV9vLOu1lAIlMT7/UIU/6wdU4BgdIJW7WU9inY4R+j+5ss/tt/pkbYkh74mQf20Zj93ugXPaY87dz5Ij3SRYnpERjTo25Prdc75B4RG/2L3p5KNvD/OKUOkNZBSlH0tlo1hjQLa3DIaHZHu50XTpabFibBOjMC5MPCUp/WSNG5JXqiEJO+6wwFQW1uOQVxlviARr6sCZID5b6eJ8ElQEQ5HFH8ku+3x woabelfast_rsa_key"
        }
    }
    tags{
      Environment = "${var.environment}"
    }    
}

resource "azurerm_public_ip" "jumpbox_public_ip" {
  name                = "jumpbox_public_ip"
  location            = "${azurerm_resource_group.dmz_rg.location}"
  resource_group_name = "${azurerm_resource_group.dmz_rg.name}"

  public_ip_address_allocation = "Dynamic"
}