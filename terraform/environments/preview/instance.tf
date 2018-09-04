# EC2 Instances in the Preview Environment

resource "aws_instance" "wordpress" {
    ami = "${var.ami}"
    count = "${var.instance_count}"
    instance_type = "${var.instance_type}"
    subnet_id = "${aws_subnet.preview_wordpress.id}"
    security_groups = ["${aws_security_group.wp_servers.id}"]
    private_ip = "${lookup(var.wp_servers_ips, count.index)}"

    tags {
        Name = "${lookup(local.wp_server_host_name, count.index)}"
        terraform = "true"
        Environment = "${var.environment}"
    }
}
resource "aws_instance" "proxy-servers" {
ami = "${var.ami}"
count = 2
instance_type = "${var.instance_type}"
private_ip = "${lookup(var.webservers_ips, count.index)}"

  tags {
    Name = "${lookup(var.webservers_names, count.index)}"
  }
}