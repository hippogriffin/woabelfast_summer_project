#Configuring Subnets for Wordpress

resource "aws_subnet" "wordpress" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.wordpress_cidr}"

  tags {
    Name        = "${var.environment} WordPress Server"
    environment = "${var.environment}"
    terraform   = "true"
  }
}

# Subnet 

resource "aws_subnet" "webserver_subnet" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.webserver_cidr}"

  tags {
    Name        = "${var.environment} Web Server"
    environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_subnet" "db_subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.db_cidr}"
  availability_zone = "${var.avail_zone_a}"

  tags {
    Name        = "${var.environment} DB Subnet"
    environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_subnet" "db_subnet_backup" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.db_cidr_bkup}"
  availability_zone = "${var.avail_zone_b}"

  tags {
    Name        = "${var.environment} DB Subnet Backup"
    environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_subnet" "public_subnet-1b" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.public_sub_1b}"
  availability_zone = "${var.avail_zone_b}"

  tags {
    Name        = "${var.environment} Public Subnet 1b"
    environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_subnet" "public_subnet-1a" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.public_sub_1a}"
  availability_zone = "${var.avail_zone_a}"

  tags {
    Name        = "${var.environment} Public Subnet 1a"
    environment = "${var.environment}"
    terraform   = "true"
  }
}