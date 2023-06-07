resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.s3_site_error
  }

  error_document {
    key = var.s3_site_index
  }
}
