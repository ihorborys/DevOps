variable "name" {
  description = "Назва бази даних (наприклад, maxgear-db)"
  type        = string
}

variable "use_aurora" {
  description = "Флаг: true для Aurora, false для звичайного RDS"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "ID нашої VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Список приватних підмереж, де буде жити база"
  type        = list(string)
}

variable "engine_version" {
  type    = string
  default = "15.4"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro" # Для Aurora треба буде змінити на db.t3.medium
}

variable "db_name" {
  type    = string
  default = "myappdb"
}

variable "username" {
  type    = string
  default = "dbadmin"
}

variable "password" {
  type      = string
  sensitive = true
}

variable "tags" {
  type    = map(string)
  default = {}
}