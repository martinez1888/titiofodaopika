#BUCKET
resource "aws_s3_bucket" "titiofodaopika" {
  bucket = "titiofodaopika"
}

#POLICY
resource "aws_s3_bucket_policy" "titiofodaopika-policy" {
  bucket = aws_s3_bucket.titiofodaopika.id

  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::titiofodaopika/*",
      }
    ]
	})
}

#VERSIONAMENTO
resource "aws_s3_bucket_versioning" "titiofodaopika" {
  bucket = aws_s3_bucket.titiofodaopika.id
  versioning_configuration {
    status = "Enabled"
  }
}

#SITE ESTÁTICO
resource "aws_s3_bucket_website_configuration" "titiofodaopika" {
  bucket = aws_s3_bucket.titiofodaopika.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

#OBJECTS
resource "aws_s3_bucket_object" "titiofodaopika" {
    bucket   = aws_s3_bucket.titiofodaopika.id
    for_each = fileset("data/", "*")
    key      = each.value
    source   = "data/${each.value}"
    content_type = "text/html"
}
