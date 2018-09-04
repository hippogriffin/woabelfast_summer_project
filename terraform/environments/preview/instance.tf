
resource "aws_instance" "proxy-" {
ami = "${var.ami}"
count = 2
instance_type = "${var.instance_type}"
private_ip = "${lookup(var.instance_ips, count.index)}"
}
