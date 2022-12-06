module "docker_image" {
  source = "terraform-aws-modules/lambda/aws//modules/docker-build"

  create_ecr_repo = true
  ecr_repo        = aws_ecr_repository.loki_ecr_repo.name
  image_tag       = var.loki_version
  source_path     = path.module
}
