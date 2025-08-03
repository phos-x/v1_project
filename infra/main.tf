terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.0"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
}

module "ecr_backend" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.4.0"

  repository_name = "product-catalog-backend"
  repository_image_tag_mutability = false
}

module "ecr_frontend" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.4.0"

  repository_name = "product-catalog-frontend"
  repository_image_tag_mutability = false
}
