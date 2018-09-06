# In ternet Gateway config for DMZ Environment

resource "aws_internet_gateway" "dmz_igw" {
    vpc_id = "${aws_vpc.dmz_vpc.id}"

    tags {
        Name = "${var.igw_name}"
        terraform = "true"
        Environment = "${var.environment}"
    }
}
