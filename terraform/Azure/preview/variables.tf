# Variables for the preview environment in Azure
variable "environment" {
  default = "preview"
}

variable "location" {
  default = "ukwest"
}

variable "azure_dmz_cidr" {
  default = "172.16.0.0/16"
}

# IP needs to change per environment #
variable "preview_cidr" {
  default = "172.17.0.0/16"
}

variable "kainos_ip" {
  default = "195.89.171.5"
}

variable "aws_mgmt_cidr" {
  default = "10.121.0.0/24"
}

variable "proxy_avset" {
  default = "proxy_avset"
}

variable "wordpress_avset" {
  default = "wordpress_avset"
}

variable "count" {
  default = "2"
}

variable "proxy_vm_size" {
  default = "Standard_B1s"
}

variable "wordpress_vm_size" {
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
    "sku"       = "7-CI"
    "version"   = "latest"
  }
}

variable "proxy_os_profile" {
  type = "map"

  default = {
    "admin_username" = "deploymentuser"
  }
}

variable "proxy_storage_os_disk" {
  type = "map"

  default = {
    "caching"           = "ReadWrite"
    "create_option"     = "FromImage"
    "managed_disk_type" = "Standard_LRS"
  }
}

variable "wordpress_storage_os_disk" {
  type = "map"

  default = {
    "caching"           = "ReadWrite"
    "create_option"     = "FromImage"
    "managed_disk_type" = "Standard_LRS"
  }
}

variable "prefix" {
  default = "wordpress"
}

# IP needs to change per environment #
variable "preview_proxy_cidr" {
  default = "172.17.1.0/24"
}

# IP needs to change per environment #
variable "preview_wordpress_cidr" {
  default = "172.17.2.0/24"
}

# IP needs to change per environment #
variable "preview_db_cidr" {
  default = "172.17.3.0/24"
}

variable "preview_webserver_name" {
  default = "webserver"
}

locals {
#  preview_webserver_ips = "172.18.0.%02d"

  preview_webserver_names = "az-pw-pxy-%02d"

  preview_webserver_tag_names = "az-pw-pxy-%02d"

  proxy_nic_name = "az-pw_pxy_nic_%02d"

  preview_webserver_os_disk = "az-pw-pxy-%02d-os-disk"

  preview_wordpress_webserver_os_disk = "az-pw-wp-%02d"

  proxy_ip_name = "az-pw-pxy-ip-%02d"

  preview_wordpress_nic_name = "az-pw-wp-nic-%02d"

  wordpress_ip_name = "az-pw-wp-ip-%02d"

  preview_wordpress_name     = "az-pw-wp-%02d"
  
  preview_wordpress_tag_name = "az-pw-wp-%02d"
}