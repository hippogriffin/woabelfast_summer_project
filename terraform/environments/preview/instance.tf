resource "aws_instance" "proxy-servers" {
ami = "${var.ami}"
count = 2
instance_type = "${var.instance_type}"
subnet_id = "${aws_subnet.preview_webserver_subnet.id}"
security_groups = ["${aws_security_group.preview_web_servers.id}"]
private_ip = "${lookup(var.webservers_ips, count.index)}"

  tags {
    Name = "${lookup(var.webservers_names, count.index)}"
  }
}