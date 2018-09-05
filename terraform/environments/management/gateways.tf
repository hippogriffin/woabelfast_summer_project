resource "aws_eip" "mgmt_nat_gw_eip" {
  vpc      = true
}

resource "aws_nat_gateway" "mgmt_nat_gw" {
    allocation_id = "${aws_eip.mgmt_nat_gw_eip.id}"
    subnet_id = "${aws_subnet.mgmt_subnet.id}"
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

resource "aws_route_table_association" "mgmt_private_route_table_association" {
  subnet_id      = "${aws_subnet.mgmt_subnet.id}"
  route_table_id = "${aws_route_table.mgmt_private_route_table.id}"
}

