terraform {
  #backend "remote" {
  # hostname = "app.terraform.io"
  #  organization = "Terraform-beginners-bootcamp-2023"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
cloud {
    organization = "Terraform-beginners-bootcamp-2023"
    workspaces {
      name = "terra-house-1"
    }
  }
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.21.0"
    }
  }
}

provider "aws" {
}
provider "random" {
  # Configuration options
}