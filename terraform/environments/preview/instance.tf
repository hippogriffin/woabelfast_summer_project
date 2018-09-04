#configure provider
provider "aws" {
    shared_credentials_file = "${var.credentials_file}"
    region = "${var.region}"
}

#configure dmz instance
resource "aws_instance" "jumpbox" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"

   tags {
       Name = "jumpbox.${var.domain_name}"
   }
}