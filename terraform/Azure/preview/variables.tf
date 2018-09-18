# Variables for the preview environment in Azure
variable "environment" {
  default = "preview"
}

variable "location" {
  default = "ukwest"
}

variable "preview_cidr" {
  default = "172.17.0.0/16"
}

variable "kainos_ip" {
  default = "195.89.171.5"
}

variable "prefix" {
  default = "wordpress"
}

variable "preview_proxy_cidr" {
  default = "172.17.1.0/24"
}

variable "preview_wordpress_cidr" {
  default = "172.17.2.0/24"
}

variable "preview_db_cidr" {
  default = "172.17.3.0/24"
}



