resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.new_eip.id}"
  subnet_id     = "${aws_subnet.preview_public_subnet-1b.id}"
  depends_on    = ["aws_internet_gateway.gw"]
}

resource "aws_eip" "new_eip" {
  vpc = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.preview_vpc.id}"
}
