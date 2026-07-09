###############################################
# AWS Secrets Manager Secrets
###############################################

resource "aws_secretsmanager_secret" "this" {

  for_each = var.secrets

  name = "${local.project_name}/${local.environment}/${each.key}"

  description = "Secret for ${each.key}"

  recovery_window_in_days = 7

  tags = merge(
    local.common_tags,
    {
      Name = each.key
    }
  )

}


###############################################
# Secret Versions
###############################################

resource "aws_secretsmanager_secret_version" "this" {

  for_each = var.secrets

  secret_id = aws_secretsmanager_secret.this[each.key].id

  secret_string = jsonencode(each.value)

}


###############################################
# IAM Policy Document
###############################################

data "aws_iam_policy_document" "secrets_access" {

  statement {

    sid = "SecretsManagerAccess"

    effect = "Allow"

    actions = [

      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"

    ]

    resources = [

      for secret in aws_secretsmanager_secret.this :
      secret.arn

    ]

  }

} ###############################################
# IAM Policy
###############################################

resource "aws_iam_policy" "secrets_access" {

  name = "${local.name_prefix}-secrets-access"

  description = "Secrets Manager Access Policy"

  policy = data.aws_iam_policy_document.secrets_access.json

  tags = local.common_tags

}
