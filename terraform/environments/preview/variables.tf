variable "aws_credentials_file" {
  default = "$HOME/.aws/credentials/aws-secret"
}

variable "region" {
  default = "eu-west-1"
}
variable "ami" {
    default = "ami-3548444c"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "domain_name" {
    default = "example.com"
}

variable "wordpress_instance_name" {
    default = "wordpress.${var.domain_name}"
}
variable "db_instance_name" {
    default = "db.${var.domain_name}"
}

variable "jumpbox_instance_name" {
    default = "jumpbox.${var.domain_name}"
}

variable "proxy_instance_name" {
    default = "proxy.${var.domain_name}"
}
variable "jenkins_instance_name" {
    default = "jenkins.${var.domain_name}"
}