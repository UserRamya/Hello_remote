
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAXZ3OMRP2FQ2ZJIPC"
  secret_key = "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"
}

#resource "aws_kms_key" "testkms" {
#  description             = "KMS key 1"
#  
#}

resource "aws_s3_bucket" "s3testbucket" {
  bucket = "harish-terraform-demo"
  acl = "private"

  lifecycle_rule {
    id = "prefix_file"
    enabled = true
    prefix = "test/"

    expiration {
        days = 60
    }
    noncurrent_version_expiration {
        days = 60
    }

  }
}



#resource "aws_s3_bucket_object" "test_policy" {
#  key                    = "tests3"
#  bucket                 = aws_s3_bucket.s3testbucket.id
#  kms_key_id = aws_kms_key.testkms.arn
#}

resource "aws_s3_bucket_policy" "s3policy" {
  bucket = aws_s3_bucket.s3testbucket.id

  policy = data.aws_iam_policy_document.allow_access.json
}

data "aws_iam_policy_document" "allow_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["536565550068"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.s3testbucket.arn,
      "${aws_s3_bucket.s3testbucket.arn}/*",
    ]
  }
}
