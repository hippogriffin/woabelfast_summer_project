#Variables for Preview Environment

variable "environment" {
  default = "preview"
}

variable "preview_wordpress_cidr" {
  default = "10.122.0.0/24"
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
  default = "10.122.0.0/16"
}


# Wordpress Servers

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


# Web Servers
variable "preview_web_servers_security_group" {
    default = "preview_web_servers"
}
