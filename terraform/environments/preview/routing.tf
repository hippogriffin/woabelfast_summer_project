resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.preview_vpc.id}"

    tags {
        Name = "Preview Private Route table"
        Environment = "${var.environment}"
        terraform = "true"
    }
}

resource "aws_route" "private_route" {
	route_table_id  = "${aws_route_table.private_route_table.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.gw.id}"
}

# Creating a route for vpc_peering between Preview and Management
resource "aws_route" "preview_to_mgmt" {
  route_table_id            = "${aws_route_table.private_route_table.id}"
  destination_cidr_block    = "${var.mgmt_sub}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.mgmt_to_preview.id}"
}

# Associate subnet private_1_subnet_eu_west_1a to private route table
resource "aws_route_table_association" "pr_1_subnet_eu_west_1a_association" {
    subnet_id = "${aws_subnet.preview_wordpress.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

# Associate subnet private_2_subnet_eu_west_1a to private route table
resource "aws_route_table_association" "pr_2_subnet_eu_west_1a_association" {
    subnet_id = "${aws_subnet.preview_webserver_subnet.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}
