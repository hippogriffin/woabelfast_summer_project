#Security Groups for the Preview Environment

# for preview db servers
resource "aws_security_group" "preview_db" {
  name        = "${var.preview_db_sg}"
  description = "Security group for db servers"
  vpc_id      = "${aws_vpc.preview_vpc.id}"

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
    cidr_blocks = ["${var.preview_wordpress_cidr}", "${var.preview_db_cidr_bkup}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.preview_db_sg}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_security_group" "preview_db_backup" {
  name   = "${var.preview_db_sg_bkup}"
  vpc_id = "${aws_vpc.preview_vpc.id}"

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
    cidr_blocks = ["${var.preview_wordpress_cidr}", "${var.preview_db_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Security Groups for the Preview Environment
  tags {
    Name        = "${var.preview_db_sg_bkup}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

# for preview wordpress servers
resource "aws_security_group" "wp_servers" {
  name        = "${var.preview_wp_servers_sg}"
  description = "Security group for Wordpress servers"
  vpc_id      = "${aws_vpc.preview_vpc.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

   ingress {
    from_port   = 10050
    to_port     = 10051
    protocol    = "tcp"
    cidr_blocks = ["10.121.0.113/32"]
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
    cidr_blocks = ["${var.preview_proxy_sub}"]
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
    cidr_blocks = ["${var.preview_proxy_sub}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.preview_wp_servers_sg}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

# for preview web servers
resource "aws_security_group" "preview_web_servers" {
  name        = "${var.preview_web_servers_sg}"
  description = "Security group for web servers"
  vpc_id      = "${aws_vpc.preview_vpc.id}"

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
    cidr_blocks = ["${var.preview_public_sub_1a}", "${var.preview_public_sub_1b}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.preview_public_sub_1a}", "${var.preview_public_sub_1b}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 10050
    to_port     = 10051
    protocol    = "tcp"
    cidr_blocks = ["10.121.0.113/32"]
  }

  tags {
    Name        = "${var.preview_web_servers_sg}"
    Environment = "${var.environment}"
    terraform   = "true"
  }
}

resource "aws_security_group" "preview_elb_public_sg" {
  name        = "preview_public_elb_sg"
  description = "public security group for Preview ELB"
  vpc_id      = "${aws_vpc.preview_vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}