#Variables for Preview Environment

variable "environment" {
    default = "preview"
}

#Wordpress Servers

variable "wp_servers_security_group" {
    default = "wp_servers"
}