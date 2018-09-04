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
