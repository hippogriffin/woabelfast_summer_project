#Variables for the Management Environment

variable "environment" {
    default = "mgmt"
}

#EC2 instance variables

variable "jenkins_ami" {
    default = "ami-00846a67"
}

variable "jenkins_instance_type" {
    default = "t2.micro"
}

variable "jenkins_name" {
    default = "jenkins"
}
