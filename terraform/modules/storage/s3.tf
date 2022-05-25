resource "random_id" "this" {
  byte_length = 8
}

resource "aws_s3_bucket" "this" {
  bucket = "${var.stage_tag}-bucket-${random_id.this.hex}"

  tags = var.default_tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket
  rule {
    id     = "all"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.bucket
  acl    = "private"
}

resource "aws_iam_user" "s3_user" {
  name = "${var.stage_tag}-teamcity-s3-user"

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-teamcity-s3-user"
  })
}

resource "aws_iam_access_key" "s3_user_key" {
  user = aws_iam_user.s3_user.name
}

resource "aws_iam_policy" "s3_user_policy" {
  name = "${var.stage_tag}-teamcity-s3-user-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "ListObjectsInBucket",
        "Effect" : "Allow",
        "Action" : ["s3:ListBucket"],
        "Resource" : [aws_s3_bucket.this.arn]
      },
      {
        "Sid" : "AllObjectActions",
        "Effect" : "Allow",
        "Action" : "s3:*Object",
        "Resource" : ["${aws_s3_bucket.this.arn}/*"]
      },
      {
        "Sid" : "BucketLocation",
        "Effect" : "Allow",
        "Action" : "s3:GetBucketLocation",
        "Resource" : [aws_s3_bucket.this.arn]
      },
      {
        "Sid" : "ListAllBuckets",
        "Effect" : "Allow",
        "Action" : "s3:ListAllMyBuckets",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "s3_user_policy_attach" {
  user       = aws_iam_user.s3_user.name
  policy_arn = aws_iam_policy.s3_user_policy.arn
}
