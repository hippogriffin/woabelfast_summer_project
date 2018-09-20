#EC2 IAM role 
resource "aws_iam_role" "ec2_iam_role" {
  name = "ec2_iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# EC2 Role Policy
resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = "${aws_iam_role.ec2_iam_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*",
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets",
        "rds:Describe*",
        "elasticache:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
      
    }
  ]
}
EOF
}

# EC2 Instance Profile
resource "aws_iam_instance_profile" "ec2_iam_profile" {
  name = "ec2_iam_profile"
  role = "${aws_iam_role.ec2_iam_role.name}"
}


#IAM for Jenkins User
resource "aws_iam_user" "jenkins" {
    name = "jenkins"
    path = "/system/"
}

resource "aws_iam_user_policy" "jenkins" {
    name = "jenkins_policy"
    user = "${aws_iam_user.jenkins.name}"

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": [
            "ec2:*",
            "iam:*",
            "rds:*",
            "route53:*",
            "acm:*",
            "s3:*",
            "elasticloadbalancing:*",
            "elasticfilesystem:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
    }
  ]
}
EOF
}
