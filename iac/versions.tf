# Este arquivo declara as versões requeridas do Terraform e dos provedores
terraform {
    required_version = ">= 1.14.3"
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 6.28"
        }
    }
}

provider "aws" {
  region = var.aws_region

  # Tags padrão aplicadas a todos os recursos
  default_tags {
    tags = {
      Projeto       = var.projeto
      CriadoPor     = "Thiago Viana & Ian Antunes"
    }
  }
}