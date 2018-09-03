#configure provider
provider "aws" {
    shared_credentials_file = "${var.aws_credentials_file}"
    region = "${var.region}"
}

#create wordpress instance
resource "aws_instance" "${var.wordpress_instance_name}" {
   ami = "${var.ami}"
   instance_type = "${var.instance_type}"

   tags {
       Name = "${var.wordpress_instance_name}"
   }
}

#create db instance
resource "aws_instance" "${var.db_instance_name}" {
   ami = "${var.ami}"
   instance_type = "${var.instance_type}"

   tags {
       Name = "${var.db_instance_name}"
   }
}

#create proxy instance
resource "aws_instance" "${var.proxy_instance_name}" {
   ami = "${var.ami}"
   instance_type = "${var.instance_type}"

   tags {
       Name = "${var.proxy_instance_name}"
   }
}

#create jumpbox instance
resource "aws_instance" "${var.jumpbox_instance_name}" {
   ami = "${var.ami}"
   instance_type = "${var.instance_type}"

   tags {
       Name = "${var.jumpbox_instance_name}"
   }
}

#create jenkins instance
resource "aws_instance" "${var.jenkins_instance_name}" {
   ami = "${var.ami}"
   instance_type = "${var.instance_type}"

   tags {
       Name = "${var.jenkins_instance_name}"
   }
}