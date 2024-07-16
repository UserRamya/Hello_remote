

terraform {
  required_providers {
    aws = {
      version = "> 2.7.0"
      #source  = "hashicorp/aws"
    }
  }
}


data "aws_key_pair" "key_pair" {
  key_name           = "test"
  include_public_key = true
}

resource "aws_instance" "ec2_new" {
  ami                    = var.ami_id
  instance_type          = var.size_ec2
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  iam_instance_profile = aws_iam_instance_profile.instance.name
  key_name = data.aws_key_pair.key_pair.key_name
  tags = {
    Name = "test"
    #  tags =var.tags_test 
  }

  depends_on = [aws_security_group.allow_tls]
  user_data = <<EOF
#!/bin/bash
sudo su
yum update -y
yum install python -y
EOF
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "allow_tls"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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

resource "aws_iam_instance_profile" "instance" {
  name = "iam_ec2"
  role = aws_iam_role.instance.name

}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.instance.name
  policy_arn = aws_iam_policy.create_policy.arn
}

resource "aws_iam_role" "instance" {
  name = "iam_ec2_role"
  path = "/"


  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Sid": "",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        }
      }
   ]
  }
EOF
}

resource "aws_iam_policy" "create_policy" {
  name   = "create_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.create_policy.json

}

data "aws_iam_policy_document" "create_policy" {
  statement {
    sid = "1"
    actions = [
      "ec2:DescribeSecurityGroups",
      "ec2:CreateTags",
      "s3:Put",
      "S3:PutBucketAcl",
      "s3:ListBucket",
      "s3:Get*"

    ]
    resources = ["*"]

  }
}





