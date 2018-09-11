resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.preview_vpc.id}"

    tags {
        Name = "Preview Private Route table"
        Environment = "${var.environment}"
        terraform = "true"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = "${aws_vpc.preview_vpc.id}"

    tags {
        Name = "Public Route table"
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

resource "aws_route_table_association" "public_subnet_eu_west_1a_association" {
    subnet_id = "${aws_subnet.preview_public_subnet-1a.id}"
    route_table_id         = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "public_subnet_eu_west_1b_association" {
    subnet_id = "${aws_subnet.preview_public_subnet-1b.id}"
    route_table_id         = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "private_db_association_1" {
    subnet_id = "${aws_subnet.preview_db_subnet.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}
resource "aws_route_table_association" "private_db_association_2" {
    subnet_id = "${aws_subnet.preview_db_subnet_backup.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}


resource "aws_route" "public_route" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

resource "aws_route53_zone" "preview" {
  name = "preview.woabelfast.co.uk"
  vpc_id = "${aws_vpc.preview_vpc.id}"


  tags {
    Environment = "preview"
  }
}

resource "aws_route53_record" "www-preview" {
  zone_id = "${aws_route53_zone.preview.zone_id}"
  name    = "www"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "preview"
  records        = ["preview.woabelfast.co.uk"]
}
