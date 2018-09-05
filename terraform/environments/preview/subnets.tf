
#Configuring Preview Subnets for Wordpress

resource "aws_subnet" "preview_wordpress" {
    #vpc_id = "${aws_vpc.preview_vpc.id}"
    vpc_id     = "${aws_vpc.vpc_public.id}"
    cidr_block = "${var.preview_wordpress_cidr}"

    tags {
        Name = "wordpress_preview"
        environment = "preview"
        terraform = "true"
    }
}
# Preview Subnet 

resource "aws_subnet" "preview_webserver_subnet" {
  #vpc_id     = "${aws_vpc.preview_vpc.id}"
   vpc_id                  = "${aws_vpc.vpc_public.id}"
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

resource "aws_subnet" "public_subnet_eu_west_1a" {
  vpc_id                  = "${aws_vpc.vpc_public.id}"
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
  tags = {
  	Name =  "public subnet"
  }
}
