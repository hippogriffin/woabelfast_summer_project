# Preview Subnet 

resource "aws_subnet" "preview_webserver_subnet" {
  vpc_id     = "${aws_vpc.preview_vpc.id}"
  cidr_block = "${var.preview_webserver_cidr}"

  tags {
    Name = "Preview Web Server"
    terraform = "true"
  }
}

resource "aws_subnet" "preview_db_subnet" {
  vpc_id     = "${aws_vpc.preview_vpc.id}"
  cidr_block = "${var.preview_db_cidr}"

  tags {
    Name = "Preview DB"
  }
}