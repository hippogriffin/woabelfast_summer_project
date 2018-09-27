#Variables for the Management Environment

variable "environment" {
  default = "mgmt"
}

#Internet gateway variables
variable "igw_name" {
  default = "mgmt_igw"
}

#NAT gateway variables
variable "natgw_name" {
  default = "mgmt_nat_gw"
}

#Private route table variables
variable "route_table_name" {
  default = "mgmt_private_route_table"
}

#VPC Peer Name

variable "vpc_peer_name" {
  default = "vpc_peer_mgmt_to_preview"
}

variable "dmz_cidr" {
  default = "10.120.0.0/24"
}

variable "mgmt_cidr" {
  default = "10.121.0.0/24"
}

variable "preview_cidr" {
  default = "10.122.0.0/16"
}

variable "azure_dmz_cidr" {
  default = "172.16.0.0/16"
}

#EC2 instance variables

variable "ami" {
  default = "ami-3548444c"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "jenkins_name" {
  default = "jenkins"
}

variable "strongswan_name" {
  default = "strongswan"
}

variable "bastion_name" {
  default = "bastion"
}

#Azure CIDR variables

variable "azure_cidr" {
  default = "172.16.0.0/16"
}

### Better naming convention required

variable "security_group_name" {
  default = "mgmt_sg"
}

variable "mgmt_key_name" {
  default = "mgmt_key"
}

variable "private_domain" {
  default = "woabelast.local"
}

locals {
  jenkins_host_name = "${var.environment}_${var.jenkins_name}.aws.${var.private_domain}"

  strongswan_host_name = "${var.environment}_${var.strongswan_name}.aws.${var.private_domain}"

  strongswan_eip_name = "${local.strongswan_host_name}_eip"
}
