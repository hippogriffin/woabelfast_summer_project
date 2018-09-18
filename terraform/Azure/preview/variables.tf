# Variables for the preview environment in Azure
variable "environment" {
  default = "preview"
}

variable "location" {
  default = "UK West"
}

variable "preview_cidr" {
  default = "172.17.0.0/16"
}

variable "proxy_as" {
  default = "proxy_as"
}

