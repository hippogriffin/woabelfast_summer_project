# Preview VPC 

resource "aws_vpc" "preview_vpc" {
  cidr_block = "10.122.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.environment}"
  }
}

# DMZ VPC Peering Connection
resource "aws_vpc_peering_connection" "DMZ" {
  peer_vpc_id   = "${data.terraform_remote_state.dmz_remote_state.dmz_vpc_id}"
  vpc_id        = "${aws_vpc.preview_vpc.id}"
  auto_accept   = true

  tags {
    Name = "VPC Peering between DMZ and Preview environments"
  }
}