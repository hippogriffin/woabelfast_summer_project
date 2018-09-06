resource "aws_route_table" "mgmt_private_route_table" {
    vpc_id = "${aws_vpc.mgmt_vpc.id}"

    tags {
        Name = "${var.route_table_name}"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}

resource "aws_route" "mgmt_private_route" {
	route_table_id  = "${aws_route_table.mgmt_private_route_table.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.mgmt_nat_gw.id}"
}

resource "aws_route_table_association" "mgmt_private_route_table_association" {
  subnet_id      = "${aws_subnet.mgmt_subnet.id}"
  route_table_id = "${aws_route_table.mgmt_private_route_table.id}"
}