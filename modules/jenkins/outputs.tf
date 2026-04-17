output "jenkins_url" {
  description = "URL для доступу до Jenkins (за умови LoadBalancer)"
  value       = "Отримайте IP через: kubectl get svc -n ${var.namespace} ${var.name}"
}

output "admin_user" {
  value = "admin"
}