###############################################
# IAM Policy
###############################################

resource "aws_iam_policy" "this" {

  name = "${local.name_prefix}-aws-load-balancer-controller"

  policy = file("${path.module}/iam-policy.json")

  tags = local.common_tags

}

###############################################
# IRSA Trust Policy
###############################################

data "aws_iam_policy_document" "assume_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {

      type = "Federated"

      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider}"
      ]

    }

    condition {

      test = "StringEquals"

      variable = "${local.oidc_provider}:sub"

      values = [
        "system:serviceaccount:kube-system:aws-load-balancer-controller"
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

  name = "${local.name_prefix}-aws-load-balancer-controller"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = local.common_tags

}

###############################################
# Policy Attachment
###############################################

resource "aws_iam_role_policy_attachment" "this" {

  role = aws_iam_role.this.name

  policy_arn = aws_iam_policy.this.arn

}
