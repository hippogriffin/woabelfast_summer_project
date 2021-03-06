#Configuring Preview Subnets for Wordpress

resource "aws_subnet" "preview_wordpress" {
  vpc_id     = "${aws_vpc.preview_vpc.id}"
  cidr_block = "${var.preview_wordpress_cidr}"

  tags {
    Name        = "wordpress_preview"
    environment = "preview"
    terraform   = "true"
  }
}

# Preview Subnet 

resource "aws_subnet" "preview_webserver_subnet" {
  vpc_id     = "${aws_vpc.preview_vpc.id}"
  cidr_block = "${var.preview_webserver_cidr}"

  tags {
    Name        = "Preview Web Server"
    environment = "preview"
    terraform   = "true"
  }
}

resource "aws_subnet" "preview_db_subnet" {
  vpc_id            = "${aws_vpc.preview_vpc.id}"
  cidr_block        = "${var.preview_db_cidr}"
  availability_zone = "${var.avail_zone_a}"

  tags {
    Name        = "Preview DB Subnet"
    environment = "preview"
    terraform   = "true"
  }
}

resource "aws_subnet" "preview_db_subnet_backup" {
  vpc_id            = "${aws_vpc.preview_vpc.id}"
  cidr_block        = "${var.preview_db_cidr_bkup}"
  availability_zone = "${var.avail_zone_b}"

  tags {
    Name        = "Preview DB Subnet Backup"
    environment = "preview"
    terraform   = "true"
  }
}

resource "aws_subnet" "preview_public_subnet-1b" {
  vpc_id            = "${aws_vpc.preview_vpc.id}"
  cidr_block        = "${var.preview_public_sub_1b}"
  availability_zone = "${var.avail_zone_b}"

  tags {
    Name        = "Preview Public Subnet 1b"
    environment = "preview"
    terraform   = "true"
  }
}

resource "aws_subnet" "preview_public_subnet-1a" {
  vpc_id            = "${aws_vpc.preview_vpc.id}"
  cidr_block        = "${var.preview_public_sub_1a}"
  availability_zone = "${var.avail_zone_a}"

  tags {
    Name        = "Preview Public Subnet 1a"
    environment = "preview"
    terraform   = "true"
  }
}
