terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0" # Твій вершн показує 6.41.0
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 3.0.0" # Твій вершн показує 3.1.0
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.0" # Твій вершн показує 3.1.1
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}