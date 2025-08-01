resource "aws_s3_bucket" "site_bucket" {
  count   = var.create_bucket ? 1 : 0
  bucket  = var.bucket_name

  depends_on = [aws_kms_key.s3_encryption_key]
}
