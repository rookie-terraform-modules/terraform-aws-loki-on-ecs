terraform {
  required_version = ">= 0.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

module "loki" {
  source = "../../"

  ecs_cluster_name = "loki"

  loki_version = "2.7.0"

  vpc_id = "vpc-1234567890abcdef0"

  subnets = [
    "subnet-1234567890abcdef0",
    "subnet-1234567890abcdef1",
    "subnet-1234567890abcdef2",
  ]

  security_group_ids = [
    "sg-1234567890abcdef0",
  ]

  loki_desired_container_count = 1

  tags = {
    Environment = "dev"
  }
}
