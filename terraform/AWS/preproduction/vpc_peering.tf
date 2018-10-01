#VPC Peering configuration

resource "aws_vpc_peering_connection" "mgmt_to_preproduction" {
  vpc_id      = "${aws_vpc.vpc.id}"
  peer_vpc_id = "${data.terraform_remote_state.woa-belfast-mgmt.mgmt_vpc_id}"
  auto_accept = "true"

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags {
    Name        = "${var.vpc_peer_name}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}

# DMZ VPC Peering Connection
resource "aws_vpc_peering_connection" "DMZ" {
  peer_vpc_id = "${data.terraform_remote_state.dmz_remote_state.dmz_vpc_id}"
  vpc_id      = "${aws_vpc.vpc.id}"
  auto_accept = true

  tags {
    Name        = "DMZ-to-${var.environment}-Peer"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}
