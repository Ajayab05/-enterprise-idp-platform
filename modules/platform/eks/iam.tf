###############################################
# EKS Cluster Assume Role Policy
###############################################

data "aws_iam_policy_document" "eks_cluster_assume_role" {

  statement {

    sid    = "EKSClusterAssumeRole"
    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "eks.amazonaws.com"
      ]

    }

    actions = [
      "sts:AssumeRole"
    ]

  }

} ###############################################
# EKS Cluster IAM Role
###############################################

resource "aws_iam_role" "cluster" {

  name = "${local.name_prefix}-eks-cluster-role"

  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-cluster-role"
    }
  )

}


resource "aws_iam_role_policy_attachment" "cluster_policy" {

  role = aws_iam_role.cluster.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}



resource "aws_iam_role_policy_attachment" "vpc_controller" {

  role = aws_iam_role.cluster.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"

}






