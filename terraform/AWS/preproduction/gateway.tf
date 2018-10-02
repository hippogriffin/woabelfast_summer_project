resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${aws_subnet.public_subnet-1b.id}"
  depends_on    = ["aws_internet_gateway.igw"]
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
}
