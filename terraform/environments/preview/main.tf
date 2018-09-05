provider "aws" {
  region = "eu-west-1"
}


resource "aws_internet_gateway" "gw" {
  #vpc_id = "${aws_vpc.preview_vpc.id}"
  vpc_id = "${aws_vpc.vpc_public.id}"
    tags {
        Name = "InternetGateway"
    }
}

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.new_eip.id}"
  subnet_id     = "${aws_subnet.preview_webserver_subnet.id}"
}

resource "aws_eip" "new_eip" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc_public.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.new_eip.id}"
    subnet_id = "${aws_subnet.public_subnet_eu_west_1a.id}"
    depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.vpc_public.id}"

    tags {
        Name = "Private route table"
    }
}

resource "aws_route" "private_route" {
	route_table_id  = "${aws_route_table.private_route_table.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.nat.id}"
}

# Associate subnet public_subnet_eu_west_1a to public route table
resource "aws_route_table_association" "public_subnet_eu_west_1a_association" {
    subnet_id = "${aws_subnet.public_subnet_eu_west_1a.id}"
    route_table_id = "${aws_vpc.vpc_public.main_route_table_id}"
}

# Associate subnet private_1_subnet_eu_west_1a to private route table
resource "aws_route_table_association" "pr_1_subnet_eu_west_1a_association" {
    subnet_id = "${aws_subnet.preview_webserver_subnet.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

# Associate subnet private_2_subnet_eu_west_1a to private route table
resource "aws_route_table_association" "pr_2_subnet_eu_west_1a_association" {
    subnet_id = "${aws_subnet.preview_webserver_subnet.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}