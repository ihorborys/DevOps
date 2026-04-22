output "db_endpoint" {
  description = "Адреса підключення до бази даних"
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].endpoint : aws_db_instance.standard[0].address
}

output "db_port" {
  description = "Порт бази даних"
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].port : aws_db_instance.standard[0].port
}

output "db_sg_id" {
  description = "ID сек'юріті групи бази"
  value       = aws_security_group.db.id
}