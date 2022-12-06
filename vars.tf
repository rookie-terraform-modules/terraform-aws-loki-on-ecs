variable "loki_version" {
  description = "The Loki version to use. See https://github.com/grafana/loki/releases for available versions"
  type        = string
  default     = "2.7.0"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster to deploy to"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy to"
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs to deploy to"
  type        = list(string)
}

variable "security_group_ids" {
  description = "A list of security group IDs to deploy to"
  type        = list(string)
}

variable "loki_desired_container_count" {
  description = "The number of Loki containers to run"
  type        = number
  default     = 1
}
