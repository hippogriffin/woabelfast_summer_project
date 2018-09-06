# Routing Table for DMZ VPC

resource "aws_route_table" "dmz_route_table" {
    vpc_id = "${aws_vpc.dmz_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.dmz_igw.id}"
    }

    tags {
        Name = "${var.route_table_name}"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}

resource "aws_route_table_association" "dmz_subnet_association" {
    subnet_id = "${aws_subnet.dmz_subnet.id}"
    route_table_id = "${aws_route_table.dmz_route_table.id}"
}