# create loki task role policy
data "aws_iam_policy_document" "loki_task_role_policy" {
  statement {
    sid = "S3Access"

    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.loki_chunks.arn,
      "${aws_s3_bucket.loki_chunks.arn}/*",
    ]
  }

  statement {
    sid = "DynamoDBAccess"

    effect = "Allow"

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:GetItem",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:CreateTable",
      "dynamodb:UpdateTable",
      "dynamodb:DeleteTable",
      "dynamodb:TagResource",
      "dynamodb:UntagResource",
      "dynamodb:ListTagsOfResource",
    ]

    resources = [
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${local.loki_index_prefix}*",
    ]
  }

  statement {
    sid = "DynamoDBListTables"

    effect = "Allow"

    actions = [
      "dynamodb:ListTables",
    ]

    resources = [
      "*",
    ]
  }
}

# create loki task execution role policy
data "aws_iam_policy_document" "loki_task_execution_role_policy" {
  statement {

    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      aws_cloudwatch_log_group.loki_log_group.arn,
      "${aws_cloudwatch_log_group.loki_log_group.arn}:*",
    ]
  }
  statement {

    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      # "kms:Decrypt", # not sure if this is needed
    ]

    resources = [
      aws_ecr_repository.loki_ecr_repo.arn,
    ]
  }
}

# create assume role policy
data "aws_iam_policy_document" "loki_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# create loki task role
resource "aws_iam_role" "loki_task_role" {
  name               = "loki-task-role-${var.ecs_cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.loki_assume_role_policy.json
  tags               = var.tags
}

# create loki task execution role
resource "aws_iam_role" "loki_task_execution_role" {
  name               = "loki-task-execution-role-${var.ecs_cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.loki_assume_role_policy.json
  tags               = var.tags
}
