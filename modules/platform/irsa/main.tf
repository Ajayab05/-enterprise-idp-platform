###############################################
# IRSA Trust Policy
###############################################

data "aws_iam_policy_document" "assume_role" {

  statement {

    sid    = "IRSAAssumeRole"

    effect = "Allow"

    principals {

      type = "Federated"

      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider}"
      ]

    }

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    condition {

      test = "StringEquals"

      variable = "${local.oidc_provider}:sub"

      values = [
        "system:serviceaccount:${var.namespace}:${var.service_account}"
      ]

    }

    condition {

      test = "StringEquals"

      variable = "${local.oidc_provider}:aud"

      values = [
        "sts.amazonaws.com"
      ]

    }

  }

}

###############################################
# IAM Role
###############################################

resource "aws_iam_role" "this" {

  name = "${local.name_prefix}-${var.role_name}"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  permissions_boundary = var.permissions_boundary

  max_session_duration = var.max_session_duration

  path = var.path

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-${var.role_name}"
    }
  )

}

###############################################
# Policy Attachments
###############################################

resource "aws_iam_role_policy_attachment" "this" {

  count = length(var.policy_arns)

  role = aws_iam_role.this.name

  policy_arn = var.policy_arns[count.index]

}
