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

variable "kainos_ip" {
  default = "195.89.171.5"
}

variable "dmz_jumpbox_name" {
    default = "dmz_jumpbox"
}

variable "nic_name" 
{
    default = "dmz_jumpbox_nic"
}

variable "aws_dmz_cidr" {
  default = "10.120.0.0/24"
}

variable "aws_strongswan" {
  default = "52.18.188.26"
}

variable "vpn_client_config" {
    default = "172.20.2.0/24"
}

variable "vpn_gw_config" {
    default = "172.16.254.0/24"
}

variable "vpn_gw_subnet_name" {
    default = "GatewaySubnet"
}

variable "vpn_client_subnet_name" {
    default = "ClientSubnet"
}