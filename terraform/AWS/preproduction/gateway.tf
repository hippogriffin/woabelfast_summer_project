resource "aws_nat_gateway" "preproduction_natgw" {
  allocation_id = "${aws_eip.preproduction_eip.id}"
  subnet_id     = "${aws_subnet.preproduction_public_subnet-1b.id}"
  depends_on    = ["aws_internet_gateway.preproduction_igw"]
}

resource "aws_eip" "preproduction_eip" {
  vpc = true
}

resource "aws_internet_gateway" "preproduction_igw" {
  vpc_id = "${aws_vpc.preproduction_vpc.id}"
}
