resource "aws_internet_gateway" "mgmt_igw" {
  vpc_id = "${aws_vpc.mgmt_vpc.id}"
  
  tags {
        Name = "${var.igw_name}"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}

resource "aws_eip" "mgmt_nat_gw_eip" {
  vpc      = true
}

resource "aws_nat_gateway" "mgmt_nat_gw" {
    allocation_id = "${aws_eip.mgmt_nat_gw_eip.id}"
    subnet_id = "${aws_subnet.mgmt_subnet.id}"

    tags {
        Name = "${var.natgw_name}"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}