# Variables for the preview environment in Azure
variable "environment" {
  default = "preview"
}
 variable "location" {
  default = "ukwest"
}
 variable "preview_cidr" {
  default = "172.17.0.0/16"
}
 variable "kainos_ip" {	
  default = "195.89.171.5"	
}
 variable "proxy_avset" {
  default = "proxy_avset"
}
 variable "proxy_server_name" {
  default = "preview-proxy-03"
}
 variable "proxy_vm_size" {
  default = "Standard_B1s"
}
 variable "proxy_ip_configuration" {
  type = "map"
  default = {
    "name"                          = "preview_proxy_ip"
    "private_ip_address_allocation" = "dynamic"
  }
}
 variable "proxy_storage_image_reference" {
  type = "map"
  default = {
    "publisher" = "OpenLogic"
    "offer"     = "CentOS"
    "sku"       = "7.3"
    "version"   = "latest"
  }
}
 variable "proxy_storage_os_disk" {
  type = "map"
  default = {
    "name"              = "proxy_os_disk"
    "caching"           = "ReadWrite"
    "create_option"     = "FromImage"
    "managed_disk_type" = "Standard_LRS"
  }
}
 variable "proxy_os_profile" {
  type = "map"
  default = {
    "computer_name"  = "preview-proxy-03"
    "admin_username" = "deploymentuser"
    "admin_password" = "deploymentpassword"
  }
} 