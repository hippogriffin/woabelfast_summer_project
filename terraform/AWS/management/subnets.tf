resource "aws_subnet" "mgmt_subnet" {
  vpc_id     = "${aws_vpc.mgmt_vpc.id}"
  cidr_block = "${var.mgmt_cidr}"

  tags {
    Name        = "mgmt_subnet"
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "mgmt_public_subnet" {
  vpc_id     = "${aws_vpc.mgmt_vpc.id}"
  cidr_block = "10.121.1.0/24"

  tags {
    Name        = "mgmt_public_subnet"
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}
