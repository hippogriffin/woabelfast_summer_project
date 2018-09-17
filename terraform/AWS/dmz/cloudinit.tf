data "template_file" "init-script" {
  template = "${file("scripts/init.cfg")}"
  vars {
    REGION = "${var.region}"
  }
}
