resource "aws_vpc_peering_connection" "dmz_mgmt_vpc_peer" {
  peer_vpc_id   = "${aws_vpc.mgmt_vpc.id}"
  vpc_id        = "${aws_vpc.dmz_vpc.id}"
  auto_accept   = true

  tags {
    Name = "dmz_mgmt_vpc_peer"
  }
}

resource "aws_route" "dmz_mgmt_vpc_peer_route" {
  route_table_id = "${aws_vpc.dmz_vpc.main_route_table_id}"
  destination_cidr_block = "${aws_vpc.mgmt_vpc.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.dmz_mgmt_vpc_peer.id}"
}

resource "aws_route" "mgmt_dmz_vpc_peer_route" {
  route_table_id = "${aws_vpc.mgmt_vpc.main_route_table_id}"
  destination_cidr_block = "${aws_vpc.dmz_vpc.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.dmz_mgmt_vpc_peer.id}"
}

resource "aws_vpc" "mgmt_vpc" {
  cidr_block = "${var.mgmt_cidr}"
}
