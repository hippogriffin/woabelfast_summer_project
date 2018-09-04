# EC2 Instances in the Preview Environment

resource "aws_instance" "wordpress" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    subnet_id = "${aws_subnet.wordpress_subnet.id}"
    security_groups = "${aws_security_group.wp_servers.id}"

    tags {
        Name = "${var.wp_server_name}"
        terraform = "true"
        Environment = "${var.environment}"
    }
}