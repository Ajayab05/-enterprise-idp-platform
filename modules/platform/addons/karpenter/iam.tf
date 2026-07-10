###############################################
# Karpenter Controller IAM Role
###############################################

resource "aws_iam_role" "karpenter_controller" {

  name = "${local.name_prefix}-karpenter-controller"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {

        Effect = "Allow"

        Principal = {
          Federated = var.oidc_provider_arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {

          StringEquals = {

            "${replace(var.cluster_oidc_issuer_url, "https://", "")}:aud" = "sts.amazonaws.com"

            "${replace(var.cluster_oidc_issuer_url, "https://", "")}:sub" = "system:serviceaccount:kube-system:karpenter"

          }

        }

      }

    ]

  })

  tags = merge(
    var.tags,
    {
      Name = "${local.name_prefix}-karpenter-controller"
    }
  )

}
