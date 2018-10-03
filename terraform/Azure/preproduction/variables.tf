# Variables for the preproduction environment in Azure

variable "environment" {
  default = "preproduction"
}

variable "location" {
  default = "ukwest"
}

variable "azure_dmz_cidr" {
  default = "172.16.0.0/16"
}

variable "kainos_ip" {
  default = "195.89.171.5"
}

variable "aws_mgmt_cidr" {
  default = "10.121.0.0/24"
}

variable "proxy_avset" {
  default = "preproduction_proxy_avset"
}

variable "wordpress_avset" {
  default = "preproduction_wordpress_avset"
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
    "name"                          = "preproduction_proxy_ip"
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
  default = "preproduction_wordpress"
}

variable "preproduction_webserver_name" {
  default = "preproduction_webserver"
}

#######################################################

## IPs required to change per environment ##
variable "cidr" {
  default = "172.18.0.0/16"
}

variable "proxy_cidr" {
  default = "172.18.1.0/24"
}

variable "wordpress_cidr" {
  default = "172.18.2.0/24"
}

variable "db_cidr" {
  default = "172.18.3.0/24"
}

variable "externallb_subnet_01_ip" {
  default = "172.18.100.0/24"
}

variable "externallb_subnet_02_ip" {
  default = "172.18.101.0/24"
}

#######################################################

locals {
# webserver_ips = "172.18.0.%02d"

  webserver_names             = "az-pp-pxy-%02d"

  webserver_tag_names         = "az-pp-pxy-%02d"

  proxy_nic_name              = "az-pp_pxy_nic_%02d"

  webserver_os_disk           = "az-pp-pxy-%02d-os-disk"

  wordpress_webserver_os_disk = "az-pp-wp-%02d"

  proxy_ip_name               = "az-pp-pxy-ip-%02d"

  wordpress_nic_name          = "az-pp-wp-nic-%02d"

  wordpress_ip_name           = "az-pp-wp-ip-%02d"

  wordpress_name              = "az-pp-wp-%02d"
  
  wordpress_tag_name          = "az-pp-wp-%02d"
}