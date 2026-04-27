# ------------- VPC -----------------
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

# ------------- EKS -----------------
# УВАГА: Перевір, щоб назви після крапки (cluster_endpoint)
# збігалися з тим, що написано в modules/eks/outputs.tf

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint # Було eks_cluster_endpoint
}

output "eks_cluster_name" {
  value = module.eks.cluster_name # Було eks_cluster_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}