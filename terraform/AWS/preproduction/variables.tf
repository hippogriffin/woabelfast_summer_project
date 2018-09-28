#Variables for Preproduction Environment

variable "environment" {
  default = "preproduction"
}

#VPC Peer Name

variable "vpc_peer_name" {
  default = "vpc_peer_preproduction_to_mgmt"
}

variable "dmz_sub" {
  default = "10.120.0.0/24"
}

variable "mgmt_sub" {
  default = "10.121.0.0/24"
}

variable "preproduction_public_sub" {
  default = "10.123.100.0/24"
}

variable "preproduction_public_sub_1a" {
  default = "10.123.102.0/24"
}

variable "preproduction_public_sub_1b" {
  default = "10.123.101.0/24"
}

#DB Server
variable "preproduction_db_sg" {
  default = "preproduction_db_rds_sg"
}

variable "preproduction_db_sg_bkup" {
  default = "preproduction_db_rds_sg_bkup"
}

#Proxy Servers
variable "preproduction_proxy_sub" {
  default = "10.123.1.0/24"
}

#Preproduction Cidr
variable "preproduction_webserver_cidr" {
  default = "10.123.1.0/24"
}

variable "preproduction_wordpress_cidr" {
  default = "10.123.2.0/24"
}

# Wordpress Servers

variable "preproduction_wp_servers_sg" {
  default = "preproduction_wp_servers"
}

#Preproduction Cidr

variable "preproduction_wp_server_name" {
  default = "wordpress"
}

variable "instance_count" {
  default = "2"
}

variable "preproduction_db_cidr" {
  default = "10.123.3.0/24"
}

variable "preproduction_db_cidr_bkup" {
  default = "10.123.4.0/24"
}

#Preproduction RDS
variable "preproduction_rds" {
  default = "preproduction_wordpress"
}

#Availability Zones
variable "avail_zone_a" {
  default = "eu-west-1a"
}

variable "avail_zone_b" {
  default = "eu-west-1b"
}

variable "private_domain" {
  default = "woabelfast_local"
}

locals {
  preproduction_wp_server_names = "aws-pp-wp-%02d"
  preproduction_wp_server_ips   = "10.123.2.%02d"
  preproduction_webserver_names = "aws-pp-pxy-%02d"
  preproduction_webserver_ips   = "10.123.1.%02d"
  preproduction_webserver_elb   = "${var.environment}-webserver-elb"
  preproduction_wp_server_elb   = "${var.environment}-wp-server-elb"
  preproduction_rds_server_elb  = "${var.environment}-rds-elb"
  preproduction_wp_env_role     = "${var.environment}_${var.preproduction_wp_server_name}"
  preproduction_proxy_env_role  = "${var.environment}_${var.preproduction_webserver_name}"
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

variable "preproduction_webserver_name" {
  default = "webserver"
}

# Web Servers
variable "preproduction_web_servers_sg" {
  default = "preproduction_web_servers"
}

#Preproduction RDS
variable "preproduction_rds_elb" {
  default = "preproduction_rds"
}

variable "kainos_cidr" {
  default = "195.89.171.5/32"
}
