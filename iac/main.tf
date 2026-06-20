# Configure the AWS provider
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Inicializa instância EC2
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "pos-web-clt"
  security_groups = ["posweb_myapp_2026"]
  region = "us-east-1"

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  # -------------------------------------------------------------------
  # DEPLOY ACONTECE AQUI
  # Este script roda quando a instância inicia (ou é substituída).
  # 1. Atualiza pacotes do sistema
  # 2. Instala Java (ajuste para sua stack: Node, Python, etc.)
  # 3. Baixa o artefato mais recente do S3
  # 4. Cria e ativa o serviço systemd da aplicação
  # -------------------------------------------------------------------
  user_data = base64encode(data.template_file.user_data.rendered)


  tags = { Name = "${var.projeto}-app-1" }
}
