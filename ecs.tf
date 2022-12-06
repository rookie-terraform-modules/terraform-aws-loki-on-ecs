# create loki task definition
resource "aws_ecs_task_definition" "loki_task_definition" {
  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.loki_task_role.arn
  execution_role_arn       = aws_iam_role.loki_task_execution_role.arn
  family                   = "loki-${var.ecs_cluster_name}"
  container_definitions = jsonencode([
    {
      name      = "loki"
      image     = "${module.docker_image.image_uri}"
      essential = true
      portMappings = [
        {
          containerPort = 3100
          hostPort      = 3100
          protocol      = "tcp"
        },
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.loki_log_group.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "loki"
        }
      }
    },
  ])
  tags = var.tags
}

# create application load balancer target group for loki
resource "aws_lb_target_group" "loki_lb_target_group" {
  name        = "loki-${var.ecs_cluster_name}"
  port        = 3100
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    path                = "/ready"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = var.tags
}

# create loki service
resource "aws_ecs_service" "loki_service" {
  name            = "loki-${var.ecs_cluster_name}"
  cluster         = data.aws_ecs_cluster.target_cluster.id
  task_definition = aws_ecs_task_definition.loki_task_definition.arn
  desired_count   = var.loki_desired_container_count
  launch_type     = "FARGATE"
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_group_ids
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.loki_lb_target_group.arn
    container_name   = "loki"
    container_port   = 3100
  }
  tags = var.tags
}
