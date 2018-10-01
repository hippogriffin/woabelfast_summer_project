resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment} Private Route table"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment} Public Route table"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = "${aws_route_table.private_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.natgw.id}"
}

# Creating a route for vpc_peering between Preproduction and Management
resource "aws_route" "preproduction_to_mgmt" {
  route_table_id            = "${aws_route_table.private_route_table.id}"
  destination_cidr_block    = "${var.mgmt_sub}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.mgmt_to_preproduction.id}"
}

# ################################################################
# Creating a route for vpc_peering between Management and Preproduction
resource "aws_route" "mgmt_to_preproduction" {
  route_table_id            = "${data.terraform_remote_state.woa-belfast-mgmt.mgmt_route_table_id}"
  destination_cidr_block    = "${aws_vpc.vpc.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.mgmt_to_preproduction.id}"
}

# Creating a route for vpc_peering between Preproduction and DMZ
resource "aws_route" "preproduction_to_dmz" {
  route_table_id            = "${aws_route_table.private_route_table.id}"
  destination_cidr_block    = "${var.dmz_sub}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.DMZ.id}"
}

resource "aws_route" "dmz_to_preproduction" {
  route_table_id            = "${data.terraform_remote_state.dmz_remote_state.dmz_route_table_id}"
  destination_cidr_block    = "${aws_vpc.vpc.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.DMZ.id}"
}

# Associate subnet private_1_subnet_eu_west_1a to private route table
resource "aws_route_table_association" "subnet_eu_west_1a_association1" {
  subnet_id      = "${aws_subnet.wordpress.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

# Associate subnet private_2_subnet_eu_west_1a to private route table
resource "aws_route_table_association" "subnet_eu_west_1a_association2" {
  subnet_id      = "${aws_subnet.webserver_subnet.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "public_subnet_eu_west_1a_association" {
  subnet_id      = "${aws_subnet.public_subnet-1a.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "public_subnet_eu_west_1b_association" {
  subnet_id      = "${aws_subnet.public_subnet-1b.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "private_db_association_1" {
  subnet_id      = "${aws_subnet.db_subnet.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "private_db_association_2" {
  subnet_id      = "${aws_subnet.db_subnet_backup.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route" "public_route" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

data "aws_route53_zone" "public_dns_zone" {
  name = "woabelfast.co.uk"
}

# Route53 record pointing to the AWS ELB 
resource "aws_route53_record" "www-preproduction-elb" {
  zone_id = "${data.aws_route53_zone.public_dns_zone.zone_id}"
  name    = "${var.environment}.woabelfast.co.uk"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "${var.environment}-elb"
  records        = ["${aws_elb.webserver_elb.dns_name}"]
}
