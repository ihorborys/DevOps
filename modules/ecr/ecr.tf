resource "aws_ecr_repository" "repo" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE" # Дозволяє переписувати теги (наприклад, замінити стару версію 'latest' на нову)

  image_scanning_configuration {
    scan_on_push = var.scan_on_push # Автоматична перевірка на вразливості при завантаженні
  }

  tags = {
    Name = var.repository_name
  }
}