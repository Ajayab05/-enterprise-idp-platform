###############################################
# EKS Worker Assume Role Policy
###############################################

data "aws_iam_policy_document" "node_assume_role" {

  statement {

    sid = "EC2AssumeRole"

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]

    }

    actions = [
      "sts:AssumeRole"
    ]

  }

} ###############################################
# Worker Node IAM Role
###############################################

resource "aws_iam_role" "node" {

  name = "${local.name_prefix}-eks-node-role"

  assume_role_policy = data.aws_iam_policy_document.node_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-node-role"
    }
  )

}




###############################################
# Worker Node Policy
###############################################

resource "aws_iam_role_policy_attachment" "node_worker" {

  role = aws_iam_role.node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}




###############################################
# ECR Pull
###############################################

resource "aws_iam_role_policy_attachment" "node_ecr" {

  role = aws_iam_role.node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"

}





###############################################
# VPC CNI
###############################################

resource "aws_iam_role_policy_attachment" "node_cni" {

  role = aws_iam_role.node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}





###############################################
# Systems Manager
###############################################

resource "aws_iam_role_policy_attachment" "node_ssm" {

  role = aws_iam_role.node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}




###############################################
# Instance Profile
###############################################

resource "aws_iam_instance_profile" "node" {

  name = "${local.name_prefix}-eks-node-profile"

  role = aws_iam_role.node.name

}



