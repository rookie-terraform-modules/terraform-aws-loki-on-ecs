output "loki_target_group_arn" {
  value       = aws_lb_target_group.loki_lb_target_group.arn
  description = "The ARN of the target group for Loki"
}
