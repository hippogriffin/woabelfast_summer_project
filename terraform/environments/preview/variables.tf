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

#EC2 instance variables

variable "ami" {
    default = "ami-00846a67"
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
