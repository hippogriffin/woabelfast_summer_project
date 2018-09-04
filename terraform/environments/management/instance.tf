#Instances for Management Environment

resource "aws_instance" "Jenkins" {
    ami = "${var.ami}"
    instance_type = "${var.jenkins_instance_type}"
    subnet_id = "${aws_subnet.management_subnet.id}"
    security_groups = ["${aws_security_group.management_sg.id}"]

    tags {
        Name = "${var.jenkins_name}"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}
