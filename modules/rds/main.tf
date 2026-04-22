# 1. Звичайна RDS (створюється, якщо use_aurora = false)
resource "aws_db_instance" "standard" {
  count = var.use_aurora ? 0 : 1

  identifier           = var.name
  engine               = "postgres"
  engine_version       = "15"
  instance_class       = var.instance_class
  allocated_storage    = 20
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]
  skip_final_snapshot  = true

  tags = var.tags
}

# 2. Aurora Cluster (створюється, якщо use_aurora = true)
resource "aws_rds_cluster" "aurora" {
  count = var.use_aurora ? 1 : 0

  cluster_identifier      = "${var.name}-cluster"
  engine                  = "aurora-postgresql"
  # Для Aurora теж краще вказати мажорну версію "15"
  engine_version          = "15"
  database_name           = var.db_name
  master_username         = var.username
  master_password         = var.password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.db.id]
  skip_final_snapshot     = true

  tags = var.tags
}

# Нода для кластера Aurora (хоча б одна потрібна для роботи)
resource "aws_rds_cluster_instance" "aurora_instance" {
  count = var.use_aurora ? 1 : 0

  identifier         = "${var.name}-aurora-node"
  cluster_identifier = aws_rds_cluster.aurora[0].id
  instance_class     = "db.t3.medium" # Aurora не підтримує мікро-інстанси
  engine             = aws_rds_cluster.aurora[0].engine
  engine_version     = aws_rds_cluster.aurora[0].engine_version

  tags = var.tags
}