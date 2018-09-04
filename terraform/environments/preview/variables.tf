#Variables for Preview Environment

variable "environment" {
    default = "preview"
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
    default = "10.122.0.0/16"
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

locals {
    wp_server_host_name = "${var.environment}_${var.wp_server_name}"
}
