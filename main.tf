# 1. Мережа (VPC)
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  vpc_name           = "vpc-django"
}

# 2. Репозиторій ECR
module "ecr" {
  source          = "./modules/ecr"
  repository_name = "django-app-repo"
}

# 3. Кластер EKS
module "eks" {
  source          = "./modules/eks"
  cluster_name    = "eks-cluster-demo"
  subnet_ids = module.vpc.private_subnet_ids

  # ПОВЕРТАЄМО ПРАЦЮЮЧИЙ ТИП
  instance_type   = "t3.small"
  capacity_type   = "SPOT"

  # ЗБІЛЬШУЄМО КІЛЬКІСТЬ (щоб вистачило RAM)
  desired_size    = 3
  max_size        = 4
  min_size        = 2
}

# 4. Модуль Jenkins
module "jenkins" {
  source         = "./modules/jenkins"
  admin_password = var.db_password
  depends_on     = [module.eks]
}

# 5. Модуль Argo CD (CD/GitOps)
module "argo_cd" {
  source     = "./modules/argo_cd"
  depends_on = [module.eks]
  repo_url   = var.github_repo_url
}

# 7. Модуль RDS (Виправлений під твої змінні)
module "rds" {
  source     = "./modules/rds"

  # Загальні назви для проекту
  name       = "production-db"
  username   = "dbadmin"
  password   = var.db_password

  vpc_id     = module.vpc.vpc_id

  # ВИПРАВЛЕНО: Використовуємо коректний output з модуля VPC
  subnet_ids = module.vpc.private_subnet_ids

  use_aurora = false # Можна змінити на true, якщо потрібна Aurora

  tags = {
    Project = "CloudInfrastructure"
  }
}

# 8. Моніторинг (Grafana + Prometheus)
module "monitoring" {
  source     = "./modules/monitoring"
  depends_on = [module.eks] # КРИТИЧНО ВАЖЛИВО
}