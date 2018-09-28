#Security Groups for the Preproduction Environment

# for preproduction db servers
resource "aws_security_group" "preproduction_db" {
  name        = "${var.preproduction_db_sg}"
  description = "Security group for Preproduction db servers"
  vpc_id      = "${aws_vpc.preproduction_vpc.id}"

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
    cidr_blocks = ["${var.preproduction_wordpress_cidr}", "${var.preproduction_db_cidr_bkup}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.preproduction_db_sg}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_security_group" "preproduction_db_backup" {
  name   = "${var.preproduction_db_sg_bkup}"
  description = "Security group for Preproduction db backup servers"
  vpc_id = "${aws_vpc.preproduction_vpc.id}"

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
    cidr_blocks = ["${var.preproduction_wordpress_cidr}", "${var.preproduction_db_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Security Groups for the Preproduction Environment
  tags {
    Name        = "${var.preproduction_db_sg_bkup}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

# for preproduction wordpress servers
resource "aws_security_group" "preproduction_wp_servers" {
  name        = "${var.preproduction_wp_servers_sg}"
  description = "Security group for Preproduction Wordpress servers"
  vpc_id      = "${aws_vpc.preproduction_vpc.id}"

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
    cidr_blocks = ["${var.preproduction_proxy_sub}"]
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
    cidr_blocks = ["${var.preproduction_proxy_sub}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.preproduction_wp_servers_sg}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

# for preproduction web servers
resource "aws_security_group" "preproduction_web_servers" {
  name        = "${var.preproduction_web_servers_sg}"
  description = "Security group for Preproduction web servers"
  vpc_id      = "${aws_vpc.preproduction_vpc.id}"

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
    cidr_blocks = ["${var.preproduction_public_sub_1a}", "${var.preproduction_public_sub_1b}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.preproduction_public_sub_1a}", "${var.preproduction_public_sub_1b}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.preproduction_web_servers_sg}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_security_group" "preproduction_elb_public_sg" {
  name        = "preproduction_public_elb_sg"
  description = "public security group for Preproduction ELB"
  vpc_id      = "${aws_vpc.preproduction_vpc.id}"

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
