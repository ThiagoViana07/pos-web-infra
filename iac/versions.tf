# Este arquivo declara as versões requeridas do Terraform e dos provedores

# Especifica a versão mínima do Terraform e a versão do provedor AWS necessária para este projeto.
terraform {
    required_version = ">= 1.14.3"
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 6.28"
        }
    }
}

# Configuração do provedor AWS
provider "aws" {
  region = var.aws_region

  # Tags padrão aplicadas a todos os recursos
  default_tags {
    tags = {
      CriadoPor     = "Thiago Viana-Ian Antunes"
    }
  }
}