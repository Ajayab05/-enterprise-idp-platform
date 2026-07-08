  ###############################################
# GitHub OIDC TLS Certificate
###############################################

data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com"
}



###############################################
# GitHub OIDC Provider
###############################################

resource "aws_iam_openid_connect_provider" "github" {

  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.github.certificates[0].sha1_fingerprint
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-github-oidc"
    }
  )
}




###############################################
# GitHub OIDC Trust Policy
###############################################

data "aws_iam_policy_document" "github_assume_role" {

  statement {

    sid    = "GitHubOIDCTrust"
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:${var.github_organization}/${var.github_repositories[0]}:ref:refs/heads/${var.github_branch}"
      ]
    }
  }
}



###############################################
# GitHub Actions IAM Role
###############################################

resource "aws_iam_role" "github_actions" {

  name = "${local.name_prefix}-github-actions"

  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-github-actions"
    }
  )
}





###############################################
# Terraform Deployment Policy
###############################################

data "aws_iam_policy_document" "terraform" {

  statement {

    sid = "TerraformBackend"

    effect = "Allow"

    actions = [
      "s3:*",
      "dynamodb:*",
      "kms:*"
    ]

    resources = [
      "*"
    ]
  }

  statement {

    sid = "Networking"

    effect = "Allow"

    actions = [
      "ec2:*"
    ]

    resources = [
      "*"
    ]
  }

  statement {

    sid = "Security"

    effect = "Allow"

    actions = [
      "logs:*",
      "iam:*"
    ]

    resources = [
      "*"
    ]
  }

}






resource "aws_iam_policy" "terraform" {

  name        = "${local.name_prefix}-terraform-policy"

  description = "Terraform deployment policy"

  policy = data.aws_iam_policy_document.terraform.json

  tags = local.common_tags
}





resource "aws_iam_role_policy_attachment" "terraform" {

  role = aws_iam_role.github_actions.name

  policy_arn = aws_iam_policy.terraform.arn

}






