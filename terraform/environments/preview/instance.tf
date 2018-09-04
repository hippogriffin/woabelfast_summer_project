resource "aws_instance" "proxy-servers" {
ami = "${var.ami}"
count = 2
instance_type = "${var.instance_type}"
private_ip = "${lookup(var.webservers_ips, count.index)}"

  tags {
    Name = "${lookup(var.webservers_names, count.index)}"
  }
}