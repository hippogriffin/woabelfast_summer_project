#Instances for Management Environment

resource "aws_instance" "Jenkins" {
    ami = "${var.ami}"
    instance_type = "${var.jenkins_instance_type}"
    subnet_id = "${aws_subnet.mgmt_subnet.id}"
    vpc_security_group_ids = ["${aws_security_group.mgmt_sg.id}"]

    tags {
        Name = "${var.jenkins_name}"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}
