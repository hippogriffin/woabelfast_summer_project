resource "aws_internet_gateway" "mgmt_int_gw" {
  vpc_id = "${aws_vpc.mgmt_vpc.id}"

  tags {
    Name = "mgmt_int_gw"
  }
}

resource "aws_route" "mgmt_internet_access" {
  route_table_id         = "${aws_vpc.mgmt_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.mgmt_int_gw.id}"
}

resource "aws_eip" "mgmt_nat_gw_eip" {
  vpc      = true
  depends_on = ["aws_internet_gateway.mgmt_int_gw"]
}

resource "aws_nat_gateway" "mgmt_nat_gw" {
    allocation_id = "${aws_eip.mgmt_nat_gw_eip.id}"
    subnet_id = "${aws_subnet.mgmt_subnet.id}"
    depends_on = ["aws_internet_gateway.mgmt_int_gw"]
}

resource "aws_route_table" "mgmt_private_route_table" {
    vpc_id = "${aws_vpc.mgmt_vpc.id}"

    tags {
        Name = "Private route table"
    }
}

resource "aws_route" "mgmt_private_route_table" {
	route_table_id  = "${aws_route_table.mgmt_private_route_table.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.mgmt_nat_gw.id}"
}
