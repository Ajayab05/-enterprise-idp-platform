###############################################
# Karpenter Controller IAM Role
###############################################

data "aws_iam_policy_document" "karpenter_controller_assume_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {

      type = "Federated"

      identifiers = [
        var.oidc_provider_arn
      ]

    }

    condition {

      test = "StringEquals"

      variable = "${replace(var.cluster_oidc_issuer_url, "https://", "")}:aud"

      values = [
        "sts.amazonaws.com"
      ]

    }

    condition {

      test = "StringEquals"

      variable = "${replace(var.cluster_oidc_issuer_url, "https://", "")}:sub"

      values = [
        "system:serviceaccount:kube-system:karpenter"
      ]

    }

  }

}

resource "aws_iam_role" "karpenter_controller" {

  name = "${local.name_prefix}-karpenter-controller"

  assume_role_policy = data.aws_iam_policy_document.karpenter_controller_assume_role.json

  tags = merge(
    var.tags,
    {
      Name = "${local.name_prefix}-karpenter-controller"
    }
  )

}
