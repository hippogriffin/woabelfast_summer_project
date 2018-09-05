resource "aws_subnet" "mgmt_subnet" {
    vpc_id = "${aws_vpc.mgmt_vpc.id}"
    cidr_block = "${var.mgmt_cidr}"

    tags {
        name = "mgmt_subnet"
        terraform = "true"
    }
}