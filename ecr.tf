# create ecr repository for loki baked image
resource "aws_ecr_repository" "loki_ecr_repo" {
  name = "loki-baked-${var.ecs_cluster_name}"
  tags = var.tags
}
