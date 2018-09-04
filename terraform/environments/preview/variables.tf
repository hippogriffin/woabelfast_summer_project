#Variables for Preview Environment

variable "environment" {
    default = "preview"
}

variable "dmz_subnet" {
    default = "10.120.0.0/24"
}


# Proxy Servers

variable "proxy_subnet" {
    default = "10.122.0.0/16"
}


# Wordpress Servers

variable "wp_servers_security_group" {
    default = "wp_servers"
}

variable "db_security_group" {
    default = "db_rds_sg"
}


# Web Servers
variable "preview_web_servers_security_group" {
    default = "preview_web_servers"
}
