#Variables for Preview Environment

variable "environment" {
    default = "preview"
}

#Wordpress Servers

variable "wp_servers_security_groups" {
    default = "wp_servers"
}