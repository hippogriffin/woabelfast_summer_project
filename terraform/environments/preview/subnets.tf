
#Configuring Preview Subnets for Wordpress

resource "aws_subnet" "preview_wordpress" {
    vpc_id = "${aws_vpc.preview_vpc.id}"
    cidr_block = "${var.preview_wordpress_cidr}"

    tags {
        Name = "wordpress_preview"
        environment = "preview"
        terraform = "true"
    }
}
# Preview Subnet 

resource "aws_subnet" "preview_webserver_subnet" {
  vpc_id     = "${aws_vpc.preview_vpc.id}"
  cidr_block = "${var.preview_webserver_cidr}"

  tags {
    Name = "Preview Web Server"
    environment = "preview"
    terraform = "true"
  }
}

resource "aws_subnet" "preview_db_subnet" {
  vpc_id     = "${aws_vpc.preview_vpc.id}"
  cidr_block = "${var.preview_db_cidr}"
  availability_zone = "${var.avail_zone_a}"

  tags {
    Name = "Preview DB Subnet"
    environment = "preview"
    terraform = "true"
  }
}

resource "aws_subnet" "preview_db_subnet_backup" {
  vpc_id     = "${aws_vpc.preview_vpc.id}"
  cidr_block = "${var.preview_db_cidr_bkup}"
  availability_zone = "${var.avail_zone_b}"

  tags {
    Name = "Preview DB Subnet Backup"
    environment = "preview"
    terraform = "true"
  }
}

resource "aws_subnet" "preview_public_subnet" {
  vpc_id = "${aws_vpc.preview_vpc.id}"
  cidr_block = "${var.preview_public_sub}"
  map_public_ip_on_launch = true

  tags {
    Name = "Preview Public Subnet"
    environment = "preview"
    terraform = "true"
  }
}
