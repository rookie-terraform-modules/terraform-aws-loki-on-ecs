# terraform-aws-loki-on-ecs

[![Github Actions](https://github.com/tobeyOguney/terraform-aws-loki-on-ecs/actions/workflows/main.yml/badge.svg)](https://github.com/tobeyOguney/terraform-aws-loki-on-ecs/actions/workflows/main.yml)
[![Releases](https://img.shields.io/github/v/release/tobeyOguney/terraform-aws-loki-on-ecs)](https://github.com/tobeyOguney/terraform-aws-loki-on-ecs/releases/latest)

[Terraform Module Registry](https://registry.terraform.io/modules/tobeyOguney/loki-on-ecs/aws)

A Terraform module to install [Loki](https://github.com/grafana/loki/) on an existing ECS cluster utilizing DynamoDB and S3 as storage backends.

Got the Loki configuration from [here](https://github.com/iplabs/terraform-kubernetes-loki-aws).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.7 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | 2.23.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.7 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | The name of the ECS cluster to deploy to | `string` | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of security group IDs to deploy to | `list(string)` | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnet IDs to deploy to | `list(string)` | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to deploy to | `string` | yes |
| <a name="input_loki_desired_container_count"></a> [loki\_desired\_container\_count](#input\_loki\_desired\_container\_count) | The number of Loki containers to run | `number` | no |
| <a name="input_loki_version"></a> [loki\_version](#input\_loki\_version) | The Loki version to use. See https://github.com/grafana/loki/releases for available versions | `string` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_loki_target_group_arn"></a> [loki\_target\_group\_arn](#output\_loki\_target\_group\_arn) | The ARN of the target group for Loki |
<!-- END_TF_DOCS -->
