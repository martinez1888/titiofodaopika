#BUCKET
resource "aws_s3_bucket" "titioembacadao" {
  bucket = "titioembacadao"
}

#VERSIONAMENTO
resource "aws_s3_bucket_versioning" "titioembacadao" {
  bucket = aws_s3_bucket.titioembacadao.id
  versioning_configuration {
    status = "Enabled"
  }
}

#SITE ESTÁTICO
resource "aws_s3_bucket_website_configuration" "titioembacadao" {
  bucket = aws_s3_bucket.titioembacadao.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

#OBJECTS
resource "aws_s3_bucket_object" "titioembacadao" {
    bucket   = aws_s3_bucket.titioembacadao.id
    for_each = fileset("data/", "*")
    key      = each.value
    source   = "data/${each.value}"
    content_type = "text/html"
}

#POLICY
resource "aws_s3_bucket_policy" "titioembacadao-policy" {
  bucket = aws_s3_bucket.titioembacadao.id

  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::titioembacadao/*",
      }
    ]
	})
}
