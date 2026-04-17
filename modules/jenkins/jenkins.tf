resource "helm_release" "jenkins" {
  name             = "jenkins"
  repository       = "https://charts.jenkins.io"
  chart            = "jenkins"
  namespace        = var.namespace
  create_namespace = true

  # Збільшуємо час очікування до 20 хвилин для стабільності на невеликих нодах
  timeout          = 1200

  # Автоматичне підчищання та можливість перезапису при збоях
  cleanup_on_fail  = true
  force_update     = true

  set = [
    {
      name  = "controller.admin.password"
      value = var.admin_password
    },
    {
      name  = "controller.service.type"
      value = "LoadBalancer"
    },
    # ТИМЧАСОВЕ РІШЕННЯ: Вимикаємо persistence, щоб Jenkins запустився без EBS-драйвера
    {
      name  = "persistence.enabled"
      value = "false"
    },
    # ОБМЕЖЕННЯ РЕСУРСІВ: Важливо для стабільної роботи на t3.small
    {
      name  = "controller.resources.requests.memory"
      value = "512Mi"
    },
    {
      name  = "controller.resources.limits.memory"
      value = "1024Mi"
    }
  ]
}