# terraform {
#   backend "s3" {
#     bucket         = "ihorborys-lesson-5-bucket"
#     key            = "lesson-5/terraform.tfstate"
#     region         = "us-west-2"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }
#
