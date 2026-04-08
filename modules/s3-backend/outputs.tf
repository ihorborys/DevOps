# modules/s3-backend/outputs.tf

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  # Переконайся, що ім'я ресурсу (aws_s3_bucket.terraform_state) збігається з твоїм main.tf в цьому модулі
  value       = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.terraform_locks.name
}