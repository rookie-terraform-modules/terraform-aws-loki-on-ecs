# create loki log group
resource "aws_cloudwatch_log_group" "loki_log_group" {
  name = "/ecs/loki-${var.ecs_cluster_name}"
  tags = var.tags
}
