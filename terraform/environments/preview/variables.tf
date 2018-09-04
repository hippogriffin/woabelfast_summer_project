#Variables for Preview Environment

variable "environment" {
  default = "preview"
}

variable "preview_wordpress_cidr" {
  default = "10.122.2.0/24"
}

variable "dmz_subnet" {
  default = "10.120.0.0/24"
}

#DB Server
variable "db_security_group" {
  default = "db_rds_sg"
}

#Proxy Servers

variable "proxy_subnet" {
  default = "10.122.1.0/24"
}

#Wordpress Servers

variable "wp_servers_security_group" {
  default = "wp_servers"
}

#Preview Cidr
variable "preview_webserver_cidr" {
  default = "10.120.1.0/24"
}

variable "preview_db_cidr" {
    default = "10.120.3.0/24"
}

variable "wp_server_name" {
    default = "wordpress"
}

variable "ami" {
  default = "ami-00846a67"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "wp_servers_ips" {
  default {
    "0" = "10.122.2.10"
    "1" = "10.122.2.11"
  }
}

variable "instance_count" {
  default = "2"
}



locals {
    wp_server_host_name { 
      "0" = "${var.environment}_${var.wp_server_name}_00"
      "1" = "${var.environment}_${var.wp_server_name}_01"
      }
}
