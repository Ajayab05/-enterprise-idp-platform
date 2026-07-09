###############################################
# System Managed Node Group
###############################################

resource "aws_eks_node_group" "system" {

  cluster_name = aws_eks_cluster.this.name

  node_group_name = "${local.name_prefix}-system"

  node_role_arn = aws_iam_role.node.arn

  subnet_ids = var.private_subnet_ids

  ###############################################
  # Capacity
  ###############################################

  scaling_config {

    desired_size = 2

    min_size = 2

    max_size = 2

  }

  ###############################################
  # Instance
  ###############################################

  instance_types = [
    var.node_instance_type
  ]

  ami_type = var.node_ami_type

  capacity_type = "ON_DEMAND"

  disk_size = var.node_disk_size

  ###############################################
  # Update Strategy
  ###############################################

  update_config {

    max_unavailable = 1

  }

  ###############################################
  # Labels
  ###############################################

  labels = {

    workload = "system"

    nodepool = "system"

  }

  ###############################################
  # Dependencies
  ###############################################

  depends_on = [

    aws_eks_cluster.this,

    aws_iam_instance_profile.node,

    aws_iam_role_policy_attachment.node_worker,

    aws_iam_role_policy_attachment.node_cni,

    aws_iam_role_policy_attachment.node_ecr,

    aws_iam_role_policy_attachment.node_ssm

  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-system"
    }
  )

}
