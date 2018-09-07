# EC2 Instances in the Preview Environment

resource "aws_instance" "wordpress" {
    ami = "${var.ami}"
    count = "${var.instance_count}"
    instance_type = "${var.wordpress_instance_type}"
    subnet_id = "${aws_subnet.preview_wordpress.id}"
    vpc_security_group_ids = ["${aws_security_group.wp_servers.id}"]
    private_ip = "${format("${local.preview_wp_server_ips}", count.index + 10)}"
    key_name = "${aws_key_pair.preview_key.key_name}"

    tags {
        Name = "${format("${local.preview_wp_server_names}", count.index + 1)}"
        terraform = "true"
        Environment = "${var.environment}"
    }
}

resource "aws_instance" "proxy-servers" {
    ami = "${var.ami}"
    count = "${var.instance_count}"
    instance_type = "${var.proxy_instance_type}"
    subnet_id = "${aws_subnet.preview_webserver_subnet.id}"
    vpc_security_group_ids = ["${aws_security_group.preview_web_servers.id}"]
    private_ip = "${format("${local.preview_webserver_ips}", count.index + 10)}"
    key_name = "${aws_key_pair.preview_key.key_name}"

    tags {
        Name = "${format("${local.preview_webserver_names}", count.index + 1)}"
    }
}