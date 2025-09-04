resource "random_id" "bucket_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "static_site" {
  bucket = "bucket-${random_id.bucket_id.hex}"
  tags = {
    Name      = "TestBucket"
    ManagedBy = "Terraform"
  }

}

resource "aws_s3_bucket_public_access_block" "disable_pab" {
  bucket                  = aws_s3_bucket.static_site.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static_site_public_read" {
  bucket = aws_s3_bucket.static_site.id
  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Sid       = "PublicReadGetObject"
          Effect    = "Allow"
          Principal = "*"
          Action    = "s3:GetObject"
          Resource  = "${aws_s3_bucket.static_site.arn}/*"
        }
      ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_site.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}