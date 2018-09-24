variable "kainos_cidr" {
    default = "195.89.171.5/32"
}

variable "dmz_cidr" {
    default = "10.120.0.0/24"
}

variable "mgmt_cidr" {
    default = "10.121.0.0/24"
}

variable "azure_cidr" {
    default = "172.16.0.0/16"
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
    default = "bastion"
}

variable "private_domain" {
    default = "woabelfast.local"
}

variable "strongswan_name" {
    default = "strongswan"
}

locals {
  bastion_host_name = "${var.environment}_${var.bastion_name}"
  bastion_eip_name  = "${local.bastion_host_name}_eip"
  jumpbox_dns_record = "${var.bastion_name}.${var.private_domain}"

  strongswan_host_name = "${var.environment}_${var.strongswan_name}"
  strongswan_eip_name  = "${local.strongswan_host_name}_eip"

  bastion_aws_dns_name = "${var.bastion_name}.aws"

  strongswan_aws_dns_name = "${var.strongswan_name}.aws"

  bastion_azure_dns_name = "${var.bastion_name}.azure"

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