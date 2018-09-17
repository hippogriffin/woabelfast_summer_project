variable "dmz_vnet_name" {
    default = "dmz_vnet"
}

variable "dmz_vnet_address_space" {
    default = "172.16.0.0/16"
}

variable "dmz_subnet_name" {
    default = "dmz_subnet"
}

variable "dmz_subnet_cidr" {
    default = "172.17.0.0/24"
}

variable "dmz_rg_name" {
    default = "dmz_rg"
}

variable "location" {
    default = "West UK"
}