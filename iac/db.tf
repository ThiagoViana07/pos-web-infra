# Esse arquivo é responsável por criar o banco de dados RDS e o grupo de segurança associado.

# O banco de dados será criado com as seguintes configurações:
resource "aws_db_instance" "myapp_db" {
  allocated_storage    = 10
  db_name              = "myapp"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "myapp_user"
  password             = "myapp_passwd"
  parameter_group_name = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.posweb_mydb_2026_sg.id]
  skip_final_snapshot  = true
  publicly_accessible = true
}

# O grupo de segurança será criado com as seguintes regras:
resource "aws_security_group" "posweb_mydb_2026_sg" {
  name        = "posweb_mydb_2026"
  description = "Allow MYDB inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "posweb_mydb_2026_sg"
  }
}

# As regras de entrada e saída do grupo de segurança serão configuradas da seguinte forma:
resource "aws_vpc_security_group_ingress_rule" "posweb_mydb_2026_allow_mysql" {
  security_group_id = aws_security_group.posweb_mydb_2026_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

# As regras de saída do grupo de segurança serão configuradas para permitir todo o tráfego IPv4:
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_mydb" {
  security_group_id = aws_security_group.posweb_mydb_2026_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}