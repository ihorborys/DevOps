variable "db_password" {
  description = "Пароль до бази даних PostgreSQL"
  type        = string
  sensitive   = true
}

variable "github_repo_url" {
  description = "URL вашого GitHub репозиторію"
  type        = string
}