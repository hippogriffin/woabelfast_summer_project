#Variables for Preview Environment

variable "environment" {
  default = "preview"
}

#VPC Peer Name

variable "vpc_peer_name" {
  default = "vpc_peer_preview_to_mgmt"
}

variable "dmz_sub" {
  default = "10.120.0.0/24"
}

variable "mgmt_sub" {
  default = "10.121.0.0/24"
}

variable "preview_public_sub" {
  default = "10.122.100.0/24"
}

#DB Server
variable "preview_db_sg" {
  default = "db_rds_sg"
}

variable "preview_db_sg_bkup" {
  default = "db_rds_sg_bkup"
}

#Proxy Servers
variable "preview_proxy_sub" {
  default = "10.122.1.0/24"
}

#Preview Cidr
variable "preview_webserver_cidr" {
  default = "10.122.1.0/24"
}

variable "preview_wordpress_cidr" {
  default = "10.122.2.0/24"
}

# Wordpress Servers

variable "preview_wp_servers_sg" {
  default = "wp_servers"
}

#Preview Cidr

variable "preview_wp_server_name" {
  default = "wordpress"
}

variable "instance_count" {
  default = "2"
}

variable "preview_db_cidr" {
  default = "10.122.3.0/24"
}

variable "preview_db_cidr_bkup" {
  default = "10.122.4.0/24"
}

#Preview RDS
variable "preview_rds" {
  default = "wordpress"
}

#Availability Zones
variable "avail_zone_a" {
  default = "eu-west-1a"
}

variable "avail_zone_b" {
  default = "eu-west-1b"
}


locals  {
  preview_wp_server_names = "${var.environment}_${var.preview_wp_server_name}_%02d"
  preview_wp_server_ips = "10.122.2.%02d"
  preview_webserver_names = "${var.environment}_${var.preview_webserver_name}_%02d"
  preview_webserver_ips = "10.122.1.%02d"
  preview_webserver_elb = "${var.environment}-webserver-elb"
  preview_wp_server_elb = "${var.environment}-wp-server-elb"
  preview_rds_server_elb = "${var.environment}-rds-elb"
}


#EC2 instance variables

variable "ami" {
  default = "ami-3548444c"
}

variable "proxy_instance_type" {
  default = "t2.micro"
}

variable "wordpress_instance_type" {
  default = "t2.micro"
}

variable "preview_webserver_name" {
  default = "proxy"
}

# Web Servers
variable "preview_web_servers_sg" {
  default = "preview_web_servers"
}

#Preview RDS
variable "preview_rds_elb" {
  default = "preview_rds"
}