#Instances for Management Environment

resource "aws_instance" "Jenkins" {
    ami = "${var.jenkins_ami}"
    instance_type = "${var.jenkins_instance_type}"
    subnet_id = "${aws_subnet.management_subent.id}"
    security_groups = ["${aws_security_group.management_sg.name}"]

    tags {
        Name = "${var.jenkins_name}"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}
