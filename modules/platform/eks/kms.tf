###############################################
# EKS KMS Policy
###############################################

data "aws_iam_policy_document" "eks_kms" {

  ###############################################
  # Root Account Permissions
  ###############################################

  statement {

    sid    = "EnableRootPermissions"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = [
      "kms:*"
    ]

    resources = [
      "*"
    ]
  }

  ###############################################
  # Allow EKS Cluster Role
  ###############################################

  statement {

    sid    = "AllowEKSClusterRole"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        aws_iam_role.cluster.arn
      ]
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:CreateGrant",
      "kms:ListGrants"
    ]

    resources = [
      "*"
    ]
  }

  ###############################################
  # Allow CloudWatch Logs
  ###############################################

  statement {

    sid    = "AllowCloudWatchLogs"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "logs.${var.aws_region}.amazonaws.com"
      ]
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:CreateGrant",
      "kms:ListGrants"
    ]

    resources = [
      "*"
    ]
  }

}

###############################################
# EKS KMS Key
###############################################

resource "aws_kms_key" "eks" {

  description = "KMS Key for EKS Secrets Encryption"

  deletion_window_in_days = 30

  enable_key_rotation = true

  policy = data.aws_iam_policy_document.eks_kms.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-kms"
    }
  )
}

###############################################
# EKS KMS Alias
###############################################

resource "aws_kms_alias" "eks" {

  name = "alias/${local.name_prefix}-eks"

  target_key_id = aws_kms_key.eks.key_id

}
