resource "aws_subnet" "mgmt_subnet" {
    vpc_id = "${aws_vpc.mgmt_vpc.id}"
    cidr_block = "${var.mgmt_cidr}"

    tags {
        Name = "mgmt_subnet"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}