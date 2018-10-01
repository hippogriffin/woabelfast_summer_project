# Variables for Preproduction Environment

variable "environment" {
  default = "preproduction"
}

# VPC Peer Name
variable "vpc_peer_name" {
  default = "vpc_peer_preproduction_to_mgmt"
}

variable "dmz_sub" {
  default = "10.120.0.0/24"
}

variable "mgmt_sub" {
  default = "10.121.0.0/24"
}

#######################################################

## IPs required to change per environment ##
variable "public_sub" {
  default = "10.124.100.0/24"
}

variable "public_sub_1a" {
  default = "10.124.102.0/24"
}

variable "public_sub_1b" {
  default = "10.124.101.0/24"
}

variable "webserver_cidr" {
  default = "10.124.1.0/24"
}

variable "wordpress_cidr" {
  default = "10.124.2.0/24"
}

variable "db_cidr" {
  default = "10.124.3.0/24"
}

variable "db_cidr_bkup" {
  default = "10.124.4.0/24"
}

variable "vpc_ip" {
  default = "10.124.0.0/16"
}


#######################################################

# DB Server
variable "db_sg" {
  default = "preproduction_db_rds_sg"
}

variable "db_sg_bkup" {
  default = "preproduction_db_rds_sg_bkup"
}

# Wordpress Servers
variable "wp_servers_sg" {
  default = "preproduction_wp_servers"
}

# Preproduction Cidr
variable "wp_server_name" {
  default = "wordpress"
}

variable "instance_count" {
  default = "2"
}

# Preproduction RDS
variable "rds_wordpress" {
  default = "preproduction_wordpress"
}

# Availability Zones
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
  wp_server_names = "aws-pp-wp-%02d"
  wp_server_ips   = "10.123.2.%02d"
  webserver_names = "aws-pp-pxy-%02d"
  webserver_ips   = "10.123.1.%02d"
  webserver_elb   = "${var.environment}-webserver-elb"
  wp_server_elb   = "${var.environment}-wp-server-elb"
  wp_env_role     = "${var.environment}_${var.wp_server_name}"
  proxy_env_role  = "${var.environment}_${var.webserver_name}"
}

# EC2 instance variables
variable "ami" {
  default = "ami-3548444c"
}

variable "proxy_instance_type" {
  default = "t2.micro"
}

variable "wordpress_instance_type" {
  default = "t2.micro"
}

variable "webserver_name" {
  default = "preproduction_webserver"
}

# Web Servers
variable "web_servers_sg" {
  default = "preproduction_web_servers_sg"
}

variable "kainos_cidr" {
  default = "195.89.171.5/32"
}