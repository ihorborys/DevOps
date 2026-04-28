# 🚀 Final DevOps Project — AWS Infrastructure with Terraform, EKS, CI/CD & Monitoring

## 📋 Опис проєкту

Фінальний проєкт розгортає повноцінну хмарну інфраструктуру на **AWS** з використанням **Terraform** (IaC), **Kubernetes (EKS)**, **CI/CD пайплайну** (Jenkins + Argo CD) та **моніторингу** (Prometheus + Grafana).

---

## 🏗️ Архітектура

```
AWS Cloud
├── VPC (підмережі, Internet Gateway, маршрутизація)
├── EKS (Kubernetes кластер)
│   ├── Jenkins (CI)
│   ├── Argo CD (CD)
│   └── Prometheus + Grafana (Моніторинг)
├── RDS / Aurora (База даних)
└── ECR (Container Registry)
```

---

## 🧱 Структура репозиторію

```
Project/
├── main.tf                   # Головний файл підключення модулів
├── backend.tf                # Налаштування бекенду (S3 + DynamoDB)
├── outputs.tf                # Загальні виводи ресурсів
│
├── modules/
│   ├── s3-backend/           # S3 бакет + DynamoDB для Terraform state
│   ├── vpc/                  # VPC, підмережі, Internet Gateway, маршрути
│   ├── ecr/                  # ECR репозиторій для Docker образів
│   ├── eks/                  # EKS кластер + EBS CSI Driver
│   ├── rds/                  # RDS / Aurora база даних
│   ├── jenkins/              # Helm-установка Jenkins
│   └── argo_cd/              # Helm-установка Argo CD + Helm-чарти застосунку
│       └── charts/           # App of Apps (applications + repositories)
│
├── charts/
│   └── django-app/           # Helm-чарт для Django застосунку
│       ├── templates/
│       │   ├── deployment.yaml
│       │   ├── service.yaml
│       │   ├── configmap.yaml
│       │   └── hpa.yaml
│       ├── Chart.yaml
│       └── values.yaml
│
└── Django/
    ├── app/
    ├── Dockerfile
    ├── Jenkinsfile
    └── docker-compose.yaml
```

---

## ⚙️ Технічний стек

| Компонент     | Технологія              |
|---------------|-------------------------|
| Хмара         | AWS                     |
| IaC           | Terraform               |
| Мережа        | VPC, Security Groups    |
| Контейнери    | EKS (Kubernetes)        |
| Registry      | ECR                     |
| База даних    | RDS / Aurora PostgreSQL |
| CI            | Jenkins                 |
| CD            | Argo CD                 |
| Моніторинг    | Prometheus + Grafana    |
| Застосунок    | Django                  |

---

## 🚀 Розгортання інфраструктури

### 1. Підготовка

```bash
terraform init
```

Перевір змінні та параметри перед застосуванням.

### 2. Розгортання

```bash
terraform apply
```

### 3. Перевірка стану ресурсів

```bash
kubectl get all -n jenkins
kubectl get all -n argocd
kubectl get all -n monitoring
```


## 👤 Автор

**Борис Ігор Романович** — DevOps курс, фінальний проєкт
