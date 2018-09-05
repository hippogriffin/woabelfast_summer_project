# Routing Table for DMZ VPC

resource "aws_route_table" "dmz_route_table" {
    vpc_id = "${aws_vpc.dmz_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.dmz_igw.id}"
    }

    tags {
        name = "${var.route_table_name}"
        terraform = "true"
        Environment = "${var.environment}"
    }
}