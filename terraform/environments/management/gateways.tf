resource "aws_internet_gateway" "mgmt_int_gw" {
  vpc_id = "${aws_vpc.mgmt_vpc.id}"

  tags {
    Name = "mgmt_int_gw"
  }
}

resource "aws_route" "mgmt_internet_access" {
  route_table_id         = "${aws_vpc.mgmt_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.mgmt_gw.id}"
}

resource "aws_eip" "mgmt_eip" {
  vpc      = true
  depends_on = ["aws_internet_gateway.mgmt_int_gw"]
}

resource "aws_nat_gateway" "mgmt_nat_gw" {
    allocation_id = "${aws_eip.mgmt_eip.id}"
    subnet_id = "${aws_subnet.mgmt_subnet.id}"
    depends_on = ["aws_internet_gateway.mgmt_int_gw"]
}

data "aws_eip" "mgmt_nat_gw_ip" {
  public_ip = "${var.public_ip}"
}

resource "aws_eip_association" "mgmt_nat_gw_ip" {
  instance_id   = "${var.instance_id}"
  allocation_id = "${data.aws_eip.proxy_ip.id}"
}
