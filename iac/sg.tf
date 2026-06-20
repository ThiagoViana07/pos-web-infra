# Esse arquivo é responsável por criar o grupo de segurança para a aplicação MyAPP.

# O grupo de segurança será criado com as seguintes regras:
resource "aws_security_group" "posweb_myapp_2026_sg" {
  name        = "posweb_myapp_2026"
  description = "Allow MyAPP inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "posweb_myapp_2026_sg"
  }
}

# As regras de entrada do grupo de segurança serão configuradas da seguinte forma:
resource "aws_vpc_security_group_ingress_rule" "posweb_myapp_2026_allow_ssh" {
  security_group_id = aws_security_group.posweb_myapp_2026_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# As regras de entrada do grupo de segurança serão configuradas para permitir tráfego HTTP e API:
resource "aws_vpc_security_group_ingress_rule" "posweb_myapp_2026_allow_http" {
  security_group_id = aws_security_group.posweb_myapp_2026_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# As regras de entrada do grupo de segurança serão configuradas para permitir tráfego da API nas portas 5000 e 5001:
resource "aws_vpc_security_group_ingress_rule" "posweb_myapp_2026_allow_api" {
  security_group_id = aws_security_group.posweb_myapp_2026_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}

# As regras de entrada do grupo de segurança serão configuradas para permitir tráfego da API na porta 5001:
resource "aws_vpc_security_group_ingress_rule" "posweb_myapp_2026_allow_api2" {
  security_group_id = aws_security_group.posweb_myapp_2026_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5001
  ip_protocol       = "tcp"
  to_port           = 5001
}

# As regras de saída do grupo de segurança serão configuradas para permitir todo o tráfego IPv4:
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.posweb_myapp_2026_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}