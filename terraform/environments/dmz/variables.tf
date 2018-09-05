variable "kainos_cidr" {
    default = "195.89.171.5/32"
}

variable "dmz_cidr" {
    default = "10.120.0.0/24"
}

variable "mgmt_cidr" {
    default = "10.121.0.0/24"
}

variable "security_group_name" {
    default = "dmz_sg"
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

variable "instance_name" {
    default = "dmz_jumpbox.woabelfast.local"
}

variable "igw_name" {
    default = "dmz_igw"
}

variable "route_table_name" {
    default = "dmz_route_table"
}
