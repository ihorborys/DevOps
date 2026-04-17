variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-west-2" # Зверни увагу: у твоєму VPC був us-west-2
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster-demo"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

# --- НОВА ЗМІННА ДЛЯ ЕКОНОМІЇ ---
variable "capacity_type" {
  description = "Type of capacity for the nodes (SPOT or ON_DEMAND)"
  type        = string
  default     = "SPOT"
}

variable "instance_type" {
  description = "EC2 instance type for the worker nodes"
  type        = string
  default     = "t3.small" # Міняємо на small для балансу ціна/якість
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}