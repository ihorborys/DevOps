# Група підмереж - кажемо AWS, у яких саме зонах можна запускати базу
resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

# Сек'юріті група - дозволяємо доступ до порту 5432 (PostgreSQL)
resource "aws_security_group" "db" {
  name        = "${var.name}-db-sg"
  vpc_id      = var.vpc_id
  description = "Allow access to PostgreSQL"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # В реальному проєкті тут має бути тільки CIDR твого EKS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}