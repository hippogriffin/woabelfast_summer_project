#Configuring Preproduction Subnets for Wordpress

resource "aws_subnet" "preproduction_wordpress" {
  vpc_id     = "${aws_vpc.preproduction_vpc.id}"
  cidr_block = "${var.preproduction_wordpress_cidr}"

  tags {
    Name        = "Preproduction WordPress Server"
    environment = "preproduction"
    terraform   = "true"
  }
}

# Preproduction Subnet 

resource "aws_subnet" "preproduction_webserver_subnet" {
  vpc_id     = "${aws_vpc.preproduction_vpc.id}"
  cidr_block = "${var.preproduction_webserver_cidr}"

  tags {
    Name        = "Preproduction Web Server"
    environment = "preproduction"
    terraform   = "true"
  }
}

resource "aws_subnet" "preproduction_db_subnet" {
  vpc_id            = "${aws_vpc.preproduction_vpc.id}"
  cidr_block        = "${var.preproduction_db_cidr}"
  availability_zone = "${var.avail_zone_a}"

  tags {
    Name        = "Preproduction DB Subnet"
    environment = "preproduction"
    terraform   = "true"
  }
}

resource "aws_subnet" "preproduction_db_subnet_backup" {
  vpc_id            = "${aws_vpc.preproduction_vpc.id}"
  cidr_block        = "${var.preproduction_db_cidr_bkup}"
  availability_zone = "${var.avail_zone_b}"

  tags {
    Name        = "Preproduction DB Subnet Backup"
    environment = "preproduction"
    terraform   = "true"
  }
}

resource "aws_subnet" "preproduction_public_subnet-1b" {
  vpc_id            = "${aws_vpc.preproduction_vpc.id}"
  cidr_block        = "${var.preproduction_public_sub_1b}"
  availability_zone = "${var.avail_zone_b}"

  tags {
    Name        = "Preproduction Public Subnet 1b"
    environment = "preproduction"
    terraform   = "true"
  }
}

resource "aws_subnet" "preproduction_public_subnet-1a" {
  vpc_id            = "${aws_vpc.preproduction_vpc.id}"
  cidr_block        = "${var.preproduction_public_sub_1a}"
  availability_zone = "${var.avail_zone_a}"

  tags {
    Name        = "Preproduction Public Subnet 1a"
    environment = "preproduction"
    terraform   = "true"
  }
}
