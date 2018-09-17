#Configuring DMZ Subnets

resource "aws_subnet" "dmz_subnet" {
    vpc_id = "${aws_vpc.dmz_vpc.id}"
    cidr_block = "${var.dmz_cidr}"

    tags {
        Name = "dmz_subnet"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}