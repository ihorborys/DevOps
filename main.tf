# 1. Мережа (VPC)
module "vpc" {
  source             = "./modules/vpc"  # ШЛЯХ МАЄ БУТИ ДО VPC!
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

  # Тепер цей зв'язок запрацює, бо ми перейменували модуль вище на "vpc"
  subnet_ids      = module.vpc.private_subnets

  instance_type   = "t3.small"
  capacity_type   = "SPOT"
  desired_size    = 2
  max_size        = 3
  min_size        = 1
}

# 4. Модуль Jenkins
module "jenkins" {
  source         = "./modules/jenkins"
  admin_password = "твій_секретний_пароль"
  depends_on     = [module.eks]
}

# 5. Модуль Argo CD (CD/GitOps)
module "argo_cd" {
  source     = "./modules/argo_cd"
  depends_on = [module.eks]

  # ДОДАЙ ЦЕЙ РЯДОК:
  # Встав сюди посилання на свій репозиторій з ДЗ або Django-проектом
  repo_url   = "https://github.com/твоє-ім'я/твій-репозиторій.git"
}

# 6. S3 Backend (Тільки якщо він тобі потрібен як ресурс)
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "terraform-state-bucket-rapidfire-unique"
  table_name  = "terraform-locks"
}