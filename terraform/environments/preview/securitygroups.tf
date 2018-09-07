#Security Groups for the Preview Environment

# for preview db servers
resource "aws_security_group" "preview_db" {
  name        = "${var.preview_db_sg}"
  description = "Security group for db servers"
  vpc_id      = "${aws_vpc.preview_vpc.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "${var.preview_wp_servers_sg}"
    Environment = "${var.environment}"
    terraform = "true"
  }
}

resource "aws_security_group" "preview_db_backup" {
  name   = "${var.preview_db_sg_bkup}"
  vpc_id = "${aws_vpc.preview_vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Security Groups for the Preview Environment
  tags {
    Name      = "${var.preview_db_sg}"
    Environment = "${var.environment}"
    terraform = "true"
  }
}

# for preview wordpress servers
resource "aws_security_group" "wp_servers" {
  name        = "${var.preview_wp_servers_sg}"
  description = "Security group for Wordpress servers"
  vpc_id      = "${aws_vpc.preview_vpc.id}"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["${var.dmz_sub}"]
  }

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["${var.preview_proxy_sub}"]
  }

   ingress {
    from_port   = "2049"
    to_port     = "2049"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["${var.preview_proxy_sub}"]
  }

  tags {
    Name      = "${var.preview_wp_servers_sg}"
    Environment = "${var.environment}"
    terraform = "true"
  }
}

# for preview web servers
resource "aws_security_group" "preview_web_servers" {
  name        = "${var.preview_web_servers_sg}"
  description = "Security group for web servers"
  vpc_id      = "${aws_vpc.preview_vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "${var.preview_web_servers_sg}" 
    Environment = "${var.environment}"
    terraform = "true"
  }
}
