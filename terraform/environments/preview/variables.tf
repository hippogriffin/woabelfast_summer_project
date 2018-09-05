#Variables for Preview Environment

variable "environment" {
  default = "preview"
}

#VPC Peer Name

variable "vpc_peer_name" {
  default = "vpc_peer_preview_to_mgmt"
}


variable "dmz_subnet" {
  default = "10.120.0.0/24"
}

#DB Server
variable "db_security_group" {
  default = "db_rds_sg"
}

# Proxy Servers

variable "proxy_subnet" {
  default = "10.122.1.0/24"
}


#Preview Cidr
variable "preview_webserver_cidr" {
  default = "10.122.1.0/24"
}

variable "preview_wordpress_cidr" {
  default = "10.122.2.0/24"
}

variable "preview_db_cidr" {
    default = "10.122.3.0/24"
}

# Wordpress Servers

variable "wp_servers_security_group" {
  default = "wp_servers"
}

variable "wp_server_name" {
    default = "wordpress"
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
      "0" = "${var.environment}_${var.wp_server_name}_01"
      "1" = "${var.environment}_${var.wp_server_name}_02"
      }
}


#EC2 instance variables

variable "ami" {
    default = "ami-3548444c"
}

variable "instance_type" {
    default = "t2.micro"
}


variable "webservers_ips" {
  default = {
    "0" = "10.0.2.10"
    "1" = "10.0.2.11"
    "2" = "10.0.2.12"
    "3" = "10.0.2.13"
    "4" = "10.0.2.14"
    "5" = "10.0.2.15"
  }
}

variable "webservers_names" {
  default = {
    "0" = "proxy-1"
    "1" = "proxy-2"
    "2" = "proxy-3"
    "3" = "proxy-4"
    "4" = "proxy-5"
    "5" = "proxy-6"
  }

}


# Web Servers
variable "preview_web_servers_security_group" {
    default = "preview_web_servers"

}


