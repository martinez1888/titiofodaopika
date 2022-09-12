#BUCKET
resource "aws_s3_bucket" "titiofodaopika1" {
  bucket = "titiofodaopika1"
}

#VERSIONAMENTO
resource "aws_s3_bucket_versioning" "titiofodaopika1" {
  bucket = aws_s3_bucket.titiofodaopika1.id
  versioning_configuration {
    status = "Enabled"
  }
}

#SITE ESTÁTICO
resource "aws_s3_bucket_website_configuration" "titiofodaopika1" {
  bucket = aws_s3_bucket.titiofodaopika1.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

#OBJECTS
resource "aws_s3_bucket_object" "titiofodaopika1" {
    bucket   = aws_s3_bucket.titiofodaopika1.id
    for_each = fileset("data/", "*")
    key      = each.value
    source   = "data/${each.value}"
    content_type = "text/html"
}

#POLICY
resource "aws_s3_bucket_policy" "titiofodaopika-policy1" {
  bucket = aws_s3_bucket.titiofodaopika1.id

  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::titiofodaopika1/*",
      }
    ]
	})
}
