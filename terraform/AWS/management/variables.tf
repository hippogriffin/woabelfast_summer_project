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

#EC2 instance variables

variable "ami" {
  default = "ami-3548444c"
}

variable "jenkins_instance_type" {
  default = "t2.micro"
}

variable "jenkins_name" {
    default = "jenkins"
}

variable "strongswan_ami" {
  default = "ami-0181f8d9b6f098ec4"
}
variable "strongswan_instance_type" {
  default = "t2.micro"
}

variable "strongswan_name" {
    default = "strongswan"
}

variable "strongswan_private_ip" {
  default = "10.121.0.164"
}

### Better naming convention required

variable "security_group_name" {
  default = "mgmt_sg"
}

variable "mgmt_key_name" {
  default = "mgmt_key"
}

locals {
  jenkins_host_name = "${var.environment}_${var.jenkins_name}"
  strongswan_host_name = "${var.environment}_${var.strongswan_name}"
  strongswan_eip_name  = "${local.strongswan_host_name}_eip"

}