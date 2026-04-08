resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.vpc_name}-public-rt" }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# --- ПРИВАТНА МАРШРУТИЗАЦІЯ (додаємо зараз) ---

# 1. Створюємо Elastic IP для NAT
resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = { Name = "${var.vpc_name}-nat-eip" }
}

# 2. Створюємо NAT Gateway (у першій публічній підмережі)
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = { Name = "${var.vpc_name}-nat-gateway" }
  depends_on = [aws_internet_gateway.igw]
}

# 3. Таблиця для приватних підмереж
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.vpc_name}-private-rt" }
}

# 4. Маршрут через NAT
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

# 5. Прив'язка приватних підмереж
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}