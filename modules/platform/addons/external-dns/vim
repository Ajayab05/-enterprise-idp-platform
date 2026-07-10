###############################################
# ExternalDNS IAM Policy
###############################################

resource "aws_iam_policy" "this" {

  name = "${local.name_prefix}-external-dns"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "route53:ChangeResourceRecordSets"
        ]

        Resource = [
          "arn:aws:route53:::hostedzone/${var.hosted_zone_id}"
        ]
      },

      {
        Effect = "Allow"

        Action = [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResource",
          "route53:GetHostedZone"
        ]

        Resource = ["*"]
      }

    ]

  })

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
        "system:serviceaccount:kube-system:external-dns"
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

  name = "${local.name_prefix}-external-dns"

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
