# DevOps Project: Infrastructure as Code & GitOps Pipeline

Цей проєкт демонструє повний цикл автоматизації: від створення хмарної інфраструктури в AWS за допомогою Terraform до налаштування CI/CD пайплайнів через Jenkins та Argo CD.

### 1. Застосування інфраструктури (Terraform)

Для розгортання кластера EKS та необхідних ресурсів AWS (S3, VPC, IAM) виконайте наступні кроки в директорії з Terraform-файлами:

1. **Ініціалізація:**
   ```bash
   terraform init
   
 ```
Перегляд плану:

Bash
terraform plan
Застосування змін:

Bash
terraform apply -auto-approve
Після завершення Terraform оновить ваш kubeconfig, щоб ви могли керувати кластером через kubectl.

2. Перевірка Jenkins Job (CI Pipeline)
Jenkins відповідає за автоматизацію процесів збірки та оновлення конфігурацій.

Доступ до інтерфейсу:
Відкрийте браузер за адресою http://localhost:8080.

Перевірка статусу:

Оберіть ваш пайплайн (наприклад, django-app-pipeline).

Перейдіть у розділ Build History.

Натисніть на останню збірку та оберіть Console Output, щоб переконатися, що всі етапи пройшли успішно.

Результат:
Jenkins автоматично оновить маніфести у репозиторії, що стане тригером для розгортання в Argo CD.

3. Візуалізація результату в Argo CD (CD Pipeline)
Argo CD реалізує GitOps-підхід, синхронізуючи стан кластера з вашим GitHub-репозиторієм.

Доступ до панелі керування:
Використовуйте port-forward для доступу до сервісу:

Bash
kubectl port-forward svc/argocd-server 8081:443 -n argocd
Адреса в браузері: https://localhost:8081.

Перевірка стану додатка:

Healthy (Зелене серце): Означає, що всі компоненти (Deployment, Pods, HPA) успішно запущені в EKS.

Synced (Зелена галочка): Означає, що стан у кластері повністю відповідає коду в GitHub.

Дерево ресурсів:
В інтерфейсі Argo CD відображається повна структура додатка: Service, ConfigMap, Deployment та Pods, що підтверджує коректну роботу Helm-чарта.

 ```

# RDS/Aurora Terraform Module

Цей модуль дозволяє розгортати або стандартний інстанс Amazon RDS (PostgreSQL/MySQL), або кластер Amazon Aurora залежно від прапора `use_aurora`.

## Приклад використання

```hcl
module "db" {
  source     = "./modules/rds"
  name       = "my-project-db"
  use_aurora = false  # Змініть на true для Aurora

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  password   = "SuperSecret123"
}

Назва,Опис,Тип,Дефолт
name,Назва бази/кластера,string,-
use_aurora,Перемикач типу бази,bool,false
vpc_id,ID мережі,string,-
subnet_ids,Список підмереж,list,-
password,Пароль адміністратора,string,-

---

### Підключення модуля в корені (`main.tf`)
Тепер виходимо з папки модуля назад у корінь проєкту і в твоєму головному `main.tf` додаємо виклик. 

**Важливо:** База не зможе створитися без мережі. Переконайся, що в тебе там уже є виклик `module "vpc"`.

```hcl
module "rds" {
  source = "./modules/rds"

  name       = "maxgear-db"
  use_aurora = false # Поки що ставимо false, щоб зекономити гроші (RDS дешевше)

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  
  username   = "postgres"
  password   = "Admin123AWS" # Краще використовувати змінні, але для ДЗ можна так
  db_name    = "maxgear"

  tags = {
    Environment = "dev"
    Project     = "Max Gear"
  }
}