resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name
  force_destroy = true # Дозволить видалити бакет через terraform destroy пізніше
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}