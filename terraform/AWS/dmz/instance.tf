#configure dmz instance
resource "aws_instance" "jumpbox" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${aws_subnet.dmz_subnet.id}"
  user_data     = "${file("scripts/init.cfg")}"

  lifecycle {
    ignore_changes = ["user_data"]
  }

  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.dmz_sg.id}"]
  key_name                    = "${aws_key_pair.dmz_key.key_name}"

  tags {
    Name        = "${local.bastion_host_name}"
    Environment = "${var.environment}"
    Role        = "${var.bastion_name}"
    EnvRole     = "dmz_bastion"
  }
}

resource "aws_eip" "jumpbox_eip" {
  instance = "${aws_instance.jumpbox.id}"
  vpc      = true

  tags {
    Name        = "${local.bastion_eip_name}"
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}
