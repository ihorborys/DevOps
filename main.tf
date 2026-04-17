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
  # ВИКОРИСТОВУЄМО ЗМІННУ ЗАМІСТЬ ТЕКСТУ
  admin_password = var.db_password
  depends_on     = [module.eks]
}

# 5. Модуль Argo CD (CD/GitOps)
module "argo_cd" {
  source     = "./modules/argo_cd"
  depends_on = [module.eks]

  # ВИКОРИСТОВУЄМО ЗМІННУ ЗАМІСТЬ ПОСИЛАННЯ
  repo_url   = var.github_repo_url
}

# 6. S3 Backend (Ресурс для стейту)
module "s3_backend" {
  source      = "./modules/s3-backend"
  # Можна також винести в змінні, якщо плануєш часто змінювати
  bucket_name = "ihorborys-hw9-state-bucket"
  table_name  = "terraform-locks"
}