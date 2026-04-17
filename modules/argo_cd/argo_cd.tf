# Основний реліз Argo CD
resource "helm_release" "argo_cd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = var.namespace
  create_namespace = true

  # Переконайся, що файл values.yaml існує в папці модуля
  values = [file("${path.module}/values.yaml")]
}

# Реліз, який деплоїть самі Application CRD (твої проєкти)
resource "helm_release" "argo_apps" {
  name       = "argo-apps"
  chart      = "${path.module}/charts" # Вказує на локальну папку charts
  namespace  = var.namespace
  depends_on = [helm_release.argo_cd]

  # ОНОВЛЕНИЙ СИНТАКСИС ДЛЯ v3.x
  set = [
    {
      name  = "repoURL"
      value = var.repo_url
    }
  ]
}