variable "kainos_cidr" {
    default = "195.89.171.5/32"
}

variable "dmz_cidr" {
    default = "10.120.0.0/24"
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

variable "domain_name" {
    default = "woabelfast.co.uk"
}

variable "server_role" {
    default = "jumpbox.woabelfast.co.uk"
}
