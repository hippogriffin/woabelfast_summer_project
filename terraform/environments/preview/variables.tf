variable "credentials_file" {
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