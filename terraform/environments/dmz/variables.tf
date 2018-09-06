variable "kainos_cidr" {
    default = "195.89.171.5/32"
}

variable "dmz_cidr" {
    default = "10.120.0.0/24"
}

variable "mgmt_cidr" {
    default = "10.121.0.0/24"
}

variable "environment" {
    default = "dmz"
}
variable "region" {
  default = "eu-west-1"
}
variable "ami" {
    default = "ami-3548444c"
}

variable "instance_type" { 
    default = "t2.micro"
}

variable "bastion_name" {
    default = "jumpbox"
}

variable "private_domain" {
    default = "woabelfast.local"
}


locals {
  bastion_host_name = "${var.environment}_${var.bastion_name}"
  bastion_eip_name  = "${local.bastion_host_name}_eip"
  jumpbox_dns_record = "${var.bastion_name}.${var.private_domain}"

}

### Better Naming convention required

variable "security_group_name" {
    default = "dmz_sg"
}

variable "igw_name" {
    default = "dmz_igw"
}

variable "instance_name" {
    default = "dmz_jumpbox.woabelfast.local"
}

variable "dmz_key_name" {
    default = "dmz_key"
}

variable "route_table_name" {
    default = "dmz_route_table"
}