terraform {
  required_version = ">= 1.1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.7"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.23.1"
    }
  }
}
