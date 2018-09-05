#configure dmz instance
resource "aws_instance" "jumpbox" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    subnet_id = "${aws_subnet.dmz_subnet.id}"
    security_groups = ["${aws_security_group.dmz_sg.id}"]
    key_name = "${var.dmz_key_name}"
    user_data = "${file("scripts/init.cfg")}"
    associate_public_ip_address = true

    tags {
        Name = "${local.bastion_host_name}"
    }
}

resource "aws_eip" "jumpbox_eip" {
    instance = "${aws_instance.jumpbox.id}"
    vpc = true

    tags {
        Name = "jumpbox_eip"
        Terraform = "true"
        environment = "${var.environment}"
    }
}