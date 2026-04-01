output "ecr_repository_url" {
  description = "URL створеного репозиторію ECR"
  value       = aws_ecr_repository.repo.repository_url
}