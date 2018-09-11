#IAM for Jenkins User

resource "aws_iam_user" "jenkins" {
    name = "jenkins"
    path = "/system/"
}

resource "aws_iam_access_key" "jenkins" {
    user = "${aws_iam_user.jenkins.name}"
}

resource "aws_iam_user_policy" "jenkins" {
    name = "jenkins_policy"
    user = "${aws_iam_user.jenkins.name}"

    policy = <<EOF
{
    "Version": "2018-09-07",
    "Statement":[
    {
        "Action": [
            "ec2:*",
            "iam:*",
            "efs:*",
            "rds:*",
            "elb:*",
            "route53:*",
            "acm:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
    }
  ]
}
EOF
}
