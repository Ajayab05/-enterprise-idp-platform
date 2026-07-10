data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "this" {

  name = var.cluster_name

}

data "tls_certificate" "oidc" {

  url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer

}

data "aws_iam_policy_document" "assume_role" {

  statement {

    sid = "IRSAAssumeRole"

    effect = "Allow"

    principals {

      type = "Federated"

      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}"
      ]

    }

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    condition {

      test = "StringEquals"

      variable = "${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:sub"

      values = [
        "system:serviceaccount:kube-system:ebs-csi-controller-sa"
      ]

    }

    condition {

      test = "StringEquals"

      variable = "${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:aud"

      values = [
        "sts.amazonaws.com"
      ]

    }

  }

}
