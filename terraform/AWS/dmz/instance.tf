#configure dmz instance
resource "aws_instance" "jumpbox" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    subnet_id = "${aws_subnet.dmz_subnet.id}"
    user_data = "${file("scripts/init.cfg")}"
    lifecycle {
  ignore_changes = ["user_data"]
}
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.dmz_sg.id}"]
    key_name = "${aws_key_pair.dmz_key.key_name}"


    tags {
        Name = "${local.bastion_host_name}"
        Environment = "${var.environment}"
        Role = "${var.bastion_name}"
        EnvRole = "${local.bastion_host_name}"
    }
}

resource "aws_eip" "jumpbox_eip" {
    instance = "${aws_instance.jumpbox.id}"
    vpc = true

    tags {
        Name = "${local.bastion_eip_name}"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}

resource "aws_instance" "strongswan" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    subnet_id = "${aws_subnet.dmz_subnet.id}"
    vpc_security_group_ids = ["${aws_security_group.dmz_sg.id}"]
    user_data = "${file("scripts/init.cfg")}"
     lifecycle {
  ignore_changes = ["user_data"]
}
    source_dest_check = false

    tags {
        Name = "${local.strongswan_host_name}"
        Environment = "${var.environment}"
        Role = "${var.strongswan_name}"
        EnvRole = "${local.strongswan_host_name}"
    }
}

resource "aws_eip" "strongswan_eip" {
    instance = "${aws_instance.strongswan.id}"
    vpc = true

    tags {
        Name = "${local.strongswan_eip_name}"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}
