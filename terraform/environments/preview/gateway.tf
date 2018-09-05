resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.new_eip.id}"
  subnet_id     = "${aws_subnet.preview_webserver_subnet.id}"
}

resource "aws_eip" "new_eip" {
  vpc      = true
}

