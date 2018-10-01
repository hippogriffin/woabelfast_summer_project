resource "aws_route_table" "preproduction_private_route_table" {
  vpc_id = "${aws_vpc.preproduction_vpc.id}"

  tags {
    Name        = "Preproduction Private Route table"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_route_table" "preproduction_public_route_table" {
  vpc_id = "${aws_vpc.preproduction_vpc.id}"

  tags {
    Name        = "Preproduction Public Route table"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_route" "preproduction_private_route" {
  route_table_id         = "${aws_route_table.preproduction_private_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.preproduction_natgw.id}"
}

# Creating a route for vpc_peering between Preproduction and Management
resource "aws_route" "preproduction_to_mgmt" {
  route_table_id            = "${aws_route_table.preproduction_private_route_table.id}"
  destination_cidr_block    = "${var.mgmt_sub}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.mgmt_to_preproduction.id}"
}

# ################################################################
# Creating a route for vpc_peering between Management and Preproduction
resource "aws_route" "mgmt_to_preproduction" {
  route_table_id            = "${data.terraform_remote_state.woa-belfast-mgmt.mgmt_route_table_id}"
  destination_cidr_block    = "${aws_vpc.preproduction_vpc.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.mgmt_to_preproduction.id}"
}

# Creating a route for vpc_peering between Preproduction and DMZ
resource "aws_route" "preproduction_to_dmz" {
  route_table_id            = "${aws_route_table.preproduction_private_route_table.id}"
  destination_cidr_block    = "${var.dmz_sub}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.DMZ.id}"
}

resource "aws_route" "dmz_to_preproduction" {
  route_table_id            = "${data.terraform_remote_state.dmz_remote_state.dmz_route_table_id}"
  destination_cidr_block    = "${aws_vpc.preproduction_vpc.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.DMZ.id}"
}

# Associate subnet preproduction_private_1_subnet_eu_west_1a to preproduction_private route table
resource "aws_route_table_association" "preproduction_1_subnet_eu_west_1a_association" {
  subnet_id      = "${aws_subnet.preproduction_wordpress.id}"
  route_table_id = "${aws_route_table.preproduction_private_route_table.id}"
}

# Associate subnet preproduction_private_2_subnet_eu_west_1a to preproduction_private route table
resource "aws_route_table_association" "preproduction_2_subnet_eu_west_1a_association" {
  subnet_id      = "${aws_subnet.preproduction_webserver_subnet.id}"
  route_table_id = "${aws_route_table.preproduction_private_route_table.id}"
}

resource "aws_route_table_association" "preproduction_public_subnet_eu_west_1a_association" {
  subnet_id      = "${aws_subnet.preproduction_public_subnet-1a.id}"
  route_table_id = "${aws_route_table.preproduction_public_route_table.id}"
}

resource "aws_route_table_association" "preproduction_public_subnet_eu_west_1b_association" {
  subnet_id      = "${aws_subnet.preproduction_public_subnet-1b.id}"
  route_table_id = "${aws_route_table.preproduction_public_route_table.id}"
}

resource "aws_route_table_association" "preproduction_private_db_association_1" {
  subnet_id      = "${aws_subnet.preproduction_db_subnet.id}"
  route_table_id = "${aws_route_table.preproduction_private_route_table.id}"
}

resource "aws_route_table_association" "preproduction_private_db_association_2" {
  subnet_id      = "${aws_subnet.preproduction_db_subnet_backup.id}"
  route_table_id = "${aws_route_table.preproduction_private_route_table.id}"
}

resource "aws_route" "preproduction_public_route" {
  route_table_id         = "${aws_route_table.preproduction_public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.preproduction_igw.id}"
}

data "aws_route53_zone" "preproduction_public_dns_zone" {
  name = "woabelfast.co.uk"
}

# Route53 record pointing to the AWS ELB 
resource "aws_route53_record" "www-preproduction-elb" {
  zone_id = "${data.aws_route53_zone.preproduction_public_dns_zone.zone_id}"
  name    = "preproduction.woabelfast.co.uk"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "preproduction-elb"
  records        = ["${aws_elb.preproduction_webserver_elb.dns_name}"]
}
