resource "aws_s3_bucket" "ebullion-pre-prod" {
  bucket = "ebullion-preprod"

  tags = {
    Name        = "My bucket"
    Environment = "Pre-Prod"
  }
}

resource "aws_s3_bucket_public_access_block" "ebullion-pre-prod-access" {
  bucket = aws_s3_bucket.ebullion-pre-prod.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
