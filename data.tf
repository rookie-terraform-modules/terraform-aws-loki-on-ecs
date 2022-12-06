data "aws_caller_identity" "current" {}

# ECR token for pushing images
data "aws_ecr_authorization_token" "current" {}

# get the ECS cluster
data "aws_ecs_cluster" "target_cluster" {
  name = var.ecs_cluster_name
}
