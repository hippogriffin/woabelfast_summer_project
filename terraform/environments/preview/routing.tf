# Create a route table
resource "aws_route_table" "preview_rt" {
  vpc_id = "${aws_vpc.preview_vpc.id}"
}

# Create a route
resource "aws_route" "preview_to_mgmt" {
  route_table_id            = "${aws_route_table.preview_rt.id}"
  destination_cidr_block    = "${var.mgmt_subnet}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.mgmt_to_preview.id}"
}