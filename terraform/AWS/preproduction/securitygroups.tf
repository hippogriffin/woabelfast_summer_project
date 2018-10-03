# Security Groups for the Preproduction Environment

# DB servers
resource "aws_security_group" "db" {
  name        = "${var.db_sg}"
  description = "Security group for ${var.environment} DB servers"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.dmz_sub}", "${var.mgmt_sub}"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.wordpress_cidr}", "${var.db_cidr_bkup}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.db_sg}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_security_group" "db_backup" {
  name   = "${var.db_sg_bkup}"
  description = "Security group for ${var.environment} DB backup servers"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.dmz_sub}", "${var.mgmt_sub}"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.wordpress_cidr}", "${var.db_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.db_sg_bkup}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

# Wordpress servers
resource "aws_security_group" "wp_servers" {
  name        = "${var.wp_servers_sg}"
  description = "Security group for ${var.environment} Wordpress servers"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.dmz_sub}", "${var.mgmt_sub}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.webserver_cidr}"]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.webserver_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.wp_servers_sg}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

# Web servers
resource "aws_security_group" "web_servers" {
  name        = "${var.web_servers_sg}"
  description = "Security group for ${var.environment} web servers"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.dmz_sub}", "${var.mgmt_sub}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.public_sub_1a}", "${var.public_sub_1b}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.public_sub_1a}", "${var.public_sub_1b}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.web_servers_sg}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_security_group" "elb_public_sg" {
  name        = "${var.environment}_public_elb_sg"
  description = "public security group for ${var.environment} ELB"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.kainos_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
