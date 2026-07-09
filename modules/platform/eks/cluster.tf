###############################################
# EKS CloudWatch Log Group
###############################################

resource "aws_cloudwatch_log_group" "eks" {

  name = "/aws/eks/${local.name_prefix}-${var.cluster_name}/cluster"

  retention_in_days = 90

  kms_key_id = aws_kms_key.eks.arn

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-control-plane-logs"
    }
  )

}



###############################################
# EKS Cluster
###############################################

resource "aws_eks_cluster" "this" {

  name = "${local.name_prefix}-${var.cluster_name}"

  version = var.cluster_version

  role_arn = aws_iam_role.cluster.arn

  deletion_protection = var.deletion_protection

  enabled_cluster_log_types = [

    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"

  ]

  ###############################################
  # Authentication
  ###############################################

  access_config {

    authentication_mode = "API_AND_CONFIG_MAP"

    bootstrap_cluster_creator_admin_permissions = true

  }

  ###############################################
  # Networking
  ###############################################

  vpc_config {

    subnet_ids = var.private_subnet_ids

    security_group_ids = [
      aws_security_group.cluster.id
    ]

    endpoint_private_access = var.cluster_private_access

    endpoint_public_access = var.cluster_public_access

    public_access_cidrs = var.cluster_public_access_cidrs

  }

  ###############################################
  # Secrets Encryption
  ###############################################

  encryption_config {

    resources = [
      "secrets"
    ]

    provider {

      key_arn = aws_kms_key.eks.arn

    }

  }

  ###############################################
  # Dependencies
  ###############################################

  depends_on = [

    aws_cloudwatch_log_group.eks,

    aws_kms_alias.eks,

    aws_iam_role_policy_attachment.cluster_policy,

    aws_iam_role_policy_attachment.vpc_controller

  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-${var.cluster_name}"
    }
  )

}
