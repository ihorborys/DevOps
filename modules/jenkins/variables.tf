variable "name" {
  description = "Назва Helm-релізу Jenkins"
  type        = string
  default     = "jenkins"
}

variable "namespace" {
  description = "Kubernetes namespace для встановлення Jenkins"
  type        = string
  default     = "jenkins"
}

variable "chart_version" {
  description = "Версія чарта Jenkins"
  type        = string
  default     = "5.7.1" # Рекомендую зафіксувати стабільну версію
}

variable "admin_password" {
  description = "Пароль адміністратора для першого входу"
  type        = string
  default     = "admin"
  sensitive   = true # Terraform приховає це значення в логах
}

variable "service_type" {
  description = "Тип сервісу (LoadBalancer або ClusterIP)"
  type        = string
  default     = "LoadBalancer"
}