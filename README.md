# 🚀 AWS EKS Infrastructure & Kubernetes Deployment (Lesson 7)

Цей проєкт демонструє створення **хмарної інфраструктури в AWS** за допомогою Terraform та розгортання масштабованого застосунку **Django** в кластері **Kubernetes (Amazon EKS)**.

## 🌟 Основні можливості
- **Orchestration**: Керування контейнерами через Amazon EKS.
- **Database**: Розгортання та підключення PostgreSQL всередині кластера.
- **Scaling**: Автоматичне масштабування подів (HPA) залежно від навантаження на CPU (1-6 реплік).
- **Infrastructure as Code**: Повний життєвий цикл ресурсів через Terraform (VPC, ECR, EKS).
- **Configuration Management**: Використання Helm-чартів та ConfigMap для керування середовищем.

---

## 📁 Структура проєкту

Проєкт організований за модульним принципом:

```text
hw_7/
├── charts/                 # Helm-чарти для розгортання застосунку
│   └── django-app/         # Шаблони Kubernetes (Deployment, Service, HPA)
├── terraform/              # Інфраструктурний код
│   ├── main.tf             # Головний файл виклику модулів (VPC, EKS, ECR)
│   ├── backend.tf          # Налаштування Remote State (S3 + DynamoDB)
│   └── modules/            # Модульна логіка (vpc, ecr, eks, s3-backend)
├── postgres.yaml           # Маніфест для розгортання PostgreSQL
├── .gitignore              # Ігнорування службових файлів Terraform та IDE
└── README.md               # Документація проєкту


🛠 Опис інфраструктури
1️⃣ Обчислювальні ресурси (EKS)
Amazon EKS Cluster: Використання керованого сервісу Kubernetes для оркестрації контейнерів.

Managed Node Groups: Використання інстансів типу t3.micro для оптимізації витрат та стабільної роботи вузлів.

Auto-scaling: Налаштовано Horizontal Pod Autoscaler (HPA) для автоматичного масштабування кількості реплік залежно від навантаження.

2️⃣ Мережа (VPC)
Ізольована мережа: Розподіл на публічні підмережі (для балансувальника) та приватні підмережі (для нод кластера).

AWS ELB (Classic Load Balancer): Забезпечує зовнішню точку доступу до Django застосунку та розподіл трафіку.

3️⃣ Зберігання даних
Amazon ECR: Приватний реєстр для безпечного зберігання та сканування Docker-образів.

PostgreSQL: Розгорнуто як окремий Deployment всередині K8s, що забезпечує потреби застосунку в базі даних у межах кластера.

🚀 Команди для керування
Керування інфраструктурою
terraform init      # Ініціалізація провайдерів та бекенду
terraform apply     # Розгортання інфраструктури в AWS
terraform destroy   # Повне видалення всіх створених ресурсів

Деплой та моніторинг застосунку
# Встановлення або оновлення застосунку через Helm
helm upgrade --install my-django ./charts/django-app

# Перевірка стану подів у реальному часі
kubectl get pods -w

# Перевірка роботи автоскейлінгу
kubectl get hpa

# Запуск міграцій бази даних усередині контейнера
kubectl exec -it <pod_name> -- python manage.py migrate

⚙️ Технічні особливості реалізації
Security: Налаштовано ALLOWED_HOSTS у Django для безпечної обробки запитів через AWS Load Balancer.

Variables: Усі конфіденційні дані (паролі БД, хости) передаються через змінні оточення та ConfigMap у Kubernetes.

Reliability: Використання Remote Backend (S3 + DynamoDB) для зберігання стану Terraform забезпечує цілісність інфраструктури та підтримку State Locking.
