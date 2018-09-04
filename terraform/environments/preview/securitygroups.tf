
resource "aws_security_group" "db" {
  name        = "${var.db_security_group}"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.preview_vpc.id}"

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
  }
}

#Security Groups for the Preview Environment

resource "aws_security_group" "wp_servers" {
    name = "${var.wp_servers_security_group}"
    description = "Security group for Wordpress servers"
    vpc_id = "${aws_vpc.preview_vpc.id}"

    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
    }
    
    ingress {
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
    }

    ingress {
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
    }

    tags {
        name = "${var.wp_servers_security_group}"
        terraform = "true"
    }
}
