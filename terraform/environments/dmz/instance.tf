#configure dmz instance
resource "aws_instance" "jumpbox" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    subnet_id = "${aws_subnet.dmz_subnet.id}"
    security_groups = ["${aws_security_group.dmz_sg.id}"]
    key_name = "${var.jumpbox_key}"

   tags {
       Name = "${var.instance_name}"
   }
}