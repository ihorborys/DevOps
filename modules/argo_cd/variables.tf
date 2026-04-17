variable "namespace" {
  type        = string
  default     = "argocd"
  description = "Namespace for Argo CD"
}

variable "repo_url" {
  type        = string
  description = "GitHub repository URL for Argo CD to watch"
}