###############################################
# Karpenter Node IAM Role
###############################################

resource "aws_iam_role" "karpenter_node" {

  name = "${local.name_prefix}-karpenter-node"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"

      }

    ]

  })

  tags = var.tags

}

###############################################
# Managed Policies
###############################################

resource "aws_iam_role_policy_attachment" "worker_node" {

  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}

resource "aws_iam_role_policy_attachment" "cni" {

  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}

resource "aws_iam_role_policy_attachment" "ecr" {

  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"

}

resource "aws_iam_role_policy_attachment" "ssm" {

  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

###############################################
# Instance Profile
###############################################

resource "aws_iam_instance_profile" "karpenter" {

  name = "${local.name_prefix}-karpenter"

  role = aws_iam_role.karpenter_node.name

}
