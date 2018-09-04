#Configuring Preview Subnets for Wordpress

resource "aws_subnet" "preview_wordpress" {
    vpc_id = "${aws_vpc.preview_vpc.id}"
    cidr_block = "${var.preview_wordpress_cidr}"

    tags {
        name = "wordpress_preview"
        environment = "preview"
        terraform = "true"
    }
}