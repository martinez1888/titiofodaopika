#BUCKET
resource "aws_s3_bucket" "titioembacado" {
  bucket = "titioembacado"
}

#VERSIONAMENTO
resource "aws_s3_bucket_versioning" "titioembacado" {
  bucket = aws_s3_bucket.titioembacado.id
  versioning_configuration {
    status = "Enabled"
  }
}

#SITE ESTÁTICO
resource "aws_s3_bucket_website_configuration" "titioembacado" {
  bucket = aws_s3_bucket.titioembacado.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

#OBJECTS
resource "aws_s3_bucket_object" "titioembacado" {
    bucket   = aws_s3_bucket.titioembacado.id
    for_each = fileset("data/", "*")
    key      = each.value
    source   = "data/${each.value}"
    content_type = "text/html"
}

#POLICY
resource "aws_s3_bucket_policy" "titioembacado-policy" {
  bucket = aws_s3_bucket.titioembacado1.id

  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::titioembacado/*",
      }
    ]
	})
}
