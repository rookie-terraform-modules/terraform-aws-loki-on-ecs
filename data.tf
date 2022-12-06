data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# ECR token for pushing images
data "aws_ecr_authorization_token" "current" {}

# get the ECS cluster
data "aws_ecs_cluster" "target_cluster" {
  cluster_name = var.ecs_cluster_name
}
