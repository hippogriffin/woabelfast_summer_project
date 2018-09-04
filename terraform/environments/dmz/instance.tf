#configure provider
provider "aws" {
    shared_credentials_file = "${var.credentials_file}"
    region = "${var.region}"
}

#configure dmz instance
resource "aws_instance" "jumpbox" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    subnet_id = "${aws_subnet.dmz_subnet.id}"
    security_groups = "${aws_security_group.dmz_sg.id}"

   tags {
       Name = "${var.environment_name}.${var.server_role}.${var.domain_name}"
   }
}