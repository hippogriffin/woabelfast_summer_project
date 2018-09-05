#Variables for the Management Environment

variable "environment" {
  default = "mgmt"
}

#VPC Peer Name

variable "vpc_peer_name" {
  default = "vpc_peer_mgmt_to_preview"
}

variable "security_group_name" {
  default = "mgmt_sg"
}

variable "dmz_cidr" {
  default = "10.120.0.0/24"
}

variable "mgmt_cidr" {
  default = "10.121.0.0/24"
}

variable "preview_cidr" {
  default = "10.122.0.0/16"
}

#EC2 instance variables

variable "ami" {
  default = "ami-3548444c"
}

variable "jenkins_instance_type" {
  default = "t2.micro"
}

variable "jenkins_name" {
    default = "jenkins"
}
