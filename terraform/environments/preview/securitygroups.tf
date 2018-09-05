#Security Groups for the Preview Environment


# for preview db servers
resource "aws_security_group" "preview_db" {
  name        = "${var.db_security_group}"
  vpc_id      = "${aws_vpc.preview_vpc.id}"

   ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

resource "aws_security_group" "preview_db_backup" {
  name        = "${var.db_security_group_bkup}"
  vpc_id      = "${aws_vpc.preview_vpc.id}"

   ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Security Groups for the Preview Environment
  tags
  {
    Name = "${var.db_security_group}"
    terraform = "true"
  }
}

# for preview wordpress servers 
resource "aws_security_group" "wp_servers" {
    name = "${var.wp_servers_security_group}"
    description = "Security group for Wordpress servers"
    vpc_id = "${aws_vpc.preview_vpc.id}"

    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["${var.dmz_subnet}"]
    }
    
    ingress {
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["${var.proxy_subnet}"]
    }

    ingress {
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["${var.proxy_subnet}"]
    }

    tags {
        Name = "${var.wp_servers_security_group}"
        terraform = "true"
    }
}


# for preview web servers 
resource "aws_security_group" "preview_web_servers" {
    name = "${var.preview_web_servers_security_group}"
    description = "Security group for web servers"
    vpc_id = "${aws_vpc.preview_vpc.id}"

    ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags {
        Name = "${var.preview_web_servers_security_group}"
        terraform = "true"
    }
}