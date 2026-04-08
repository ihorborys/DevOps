variable "repository_name" {
  description = "Назва репозиторію ECR"
  type        = string
}

variable "environment" {
  description = "Середовище (dev, prod тощо)"
  type        = string
  default     = "dev"
}

variable "scan_on_push" {
  description = "Чи сканувати образи при пуші"
  type        = bool
  default     = true
}