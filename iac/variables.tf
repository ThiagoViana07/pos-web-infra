# Configuração das variáveis do Terraform

# Este arquivo define as variáveis utilizadas no projeto, incluindo a região da AWS e a identificação do projeto.
variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  # default     = "sa-east-1"
}

