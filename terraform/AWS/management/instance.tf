#Instances for Management Environment

resource "aws_instance" "Jenkins" {
    ami = "${var.ami}"
    instance_type = "${var.jenkins_instance_type}"
    subnet_id = "${aws_subnet.mgmt_subnet.id}"
    vpc_security_group_ids = ["${aws_security_group.mgmt_sg.id}"]
    user_data = "${file("scripts/init.cfg")}"
     lifecycle {
  ignore_changes = ["user_data"]
}
    iam_instance_profile = "${aws_iam_instance_profile.ec2_iam_profile.name}"

    tags {
        Name = "${local.jenkins_host_name}"
        Environment = "${var.environment}"
        Role = "${var.jenkins_name}"
        EnvRole = "${local.jenkins_host_name}"
    }
}

resource "aws_instance" "strongswan" {
    ami = "${var.strongswan_ami}"
    instance_type = "${var.strongswan_instance_type}"
    subnet_id = "${aws_subnet.mgmt_subnet.id}"
    vpc_security_group_ids = ["${aws_security_group.mgmt_sg.id}"]
    user_data = "${file("scripts/init.cfg")}"
     lifecycle {
  ignore_changes = ["user_data"]
}
    iam_instance_profile = "${aws_iam_instance_profile.ec2_iam_profile.name}"
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
