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

resource "aws_route" "mgmt_to_dmz" {
  route_table_id            = "${aws_route_table.mgmt_private_route_table.id}"
  destination_cidr_block    = "${var.dmz_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.dmz_mgmt_vpc_peer.id}"
}

resource "aws_route_table" "mgmt_public_route_table" {
  vpc_id = "${aws_vpc.mgmt_vpc.id}"

  tags {
      Name = "mgmt_public_route_table"
      Terraform = "true"
      Environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "mgmt_public_route_table_association" {
  subnet_id      = "${aws_subnet.mgmt_public_subnet.id}"
  route_table_id = "${aws_route_table.mgmt_public_route_table.id}"
}

resource "aws_route" "mgmt_public_route" {
  route_table_id = "${aws_route_table.mgmt_public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.mgmt_igw.id}"
}

resource "aws_route" "mgmt_to_azure_private_route" {
        route_table_id = "${aws_route_table.mgmt_private_route_table.id}"
        destination_cidr_block = "172.16.0.0/16"
        instance_id = "${aws_instance.strongswan.id}"
    }

resource "aws_route" "mgmt_to_azure_public_route" {
        route_table_id = "${aws_route_table.mgmt_public_route_table.id}"
        destination_cidr_block = "172.16.0.0/16"
        instance_id = "${aws_instance.strongswan.id}"
    }