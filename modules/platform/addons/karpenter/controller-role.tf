###############################################
# Karpenter Controller IAM Role
###############################################

resource "aws_iam_role" "karpenter_controller" {

  name = "${local.name_prefix}-karpenter-controller"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
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
    }]
  })

  tags = merge(
    var.tags,
    {
      Name = "${local.name_prefix}-karpenter-controller"
    }
  )
}

###############################################
# Controller IAM Policy
###############################################

resource "aws_iam_policy" "karpenter_controller" {

  name        = "${local.name_prefix}-karpenter-controller"
  description = "Karpenter Controller Policy"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeImages",
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplates",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSpotPriceHistory",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeVolumes",
          "ec2:DescribeInstanceTypeOfferings",
          "ec2:RunInstances",
          "ec2:TerminateInstances",
          "ec2:CreateFleet",
          "ec2:CreateLaunchTemplate",
          "ec2:DeleteLaunchTemplate",
          "ec2:CreateTags"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "pricing:GetProducts"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "ssm:GetParameter"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "eks:DescribeCluster"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "iam:GetInstanceProfile",
          "iam:CreateInstanceProfile",
          "iam:DeleteInstanceProfile",
          "iam:AddRoleToInstanceProfile",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:TagInstanceProfile",
          "iam:PassRole"
        ]

        Resource = "*"
      }

    ]
  })

  tags = var.tags
}

###############################################
# Attach Policy
###############################################

resource "aws_iam_role_policy_attachment" "controller" {

  role       = aws_iam_role.karpenter_controller.name

  policy_arn = aws_iam_policy.karpenter_controller.arn

}
