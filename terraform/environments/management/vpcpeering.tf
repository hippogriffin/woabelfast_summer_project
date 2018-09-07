data "terraform_remote_state" "woa-belfast" {
  backend = "s3"
  config {
    bucket = "woa-belfast"
    key = "dmz/woa.tfstate"
    region = "eu-west-1"
  }
}

resource "aws_vpc_peering_connection" "dmz_mgmt_vpc_peer" {
  peer_vpc_id   = "${data.terraform_remote_state.woa-belfast.dmz_vpc_id}"
  vpc_id        = "${aws_vpc.mgmt_vpc.id}"
  auto_accept   = true

  tags {
    Name = "dmz_mgmt_vpc_peer"
    Terraform = "true"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "dmz_mgmt_vpc_peer_route" {
  route_table_id = "${data.terraform_remote_state.woa-belfast.dmz_route_table_id}"
  destination_cidr_block = "${aws_vpc.mgmt_vpc.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.dmz_mgmt_vpc_peer.id}"
}

resource "aws_route" "mgmt_dmz_vpc_peer_route" {
  route_table_id = "${aws_vpc.mgmt_vpc.main_route_table_id}"
  destination_cidr_block = "${data.terraform_remote_state.woa-belfast.dmz_vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.dmz_mgmt_vpc_peer.id}"
}
