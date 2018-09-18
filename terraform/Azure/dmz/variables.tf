variable "dmz_vnet_name" {
    default = "dmz_vnet"
}

variable "dmz_vnet_address_space" {
    default = "172.16.0.0/16"
}

variable "dmz_rg_name" {
    default = "dmz_rg"
}

variable "location" {
    default = "ukwest"
}

variable "dmz_subnet_name" {
    default = "dmz_subnet"
}

variable "jumpbox_subnet_name" {
    default = "jumpbox_subnet"
}

variable "kainos_ip" {
  default = "195.89.171.5"
}