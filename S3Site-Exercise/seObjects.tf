resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "index.html"
  source       = "site/index.html"
  etag         = filemd5("site/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "error.html"
  source       = "site/error.html"
  etag         = filemd5("site/error.html")
  content_type = "text/html"
}