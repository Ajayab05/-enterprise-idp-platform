###############################################
# EKS Cluster Security Group
###############################################

resource "aws_security_group" "cluster" {

  name = "${local.name_prefix}-eks-cluster-sg"

  description = "Security Group for EKS Control Plane"

  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-cluster-sg"

      "kubernetes.io/cluster/${local.name_prefix}-${var.cluster_name}" = "owned"
    }
  )

}



###############################################
# EKS Node Security Group
###############################################

resource "aws_security_group" "node" {

  name = "${local.name_prefix}-eks-node-sg"

  description = "Security Group for EKS Worker Nodes"

  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-node-sg"

      "kubernetes.io/cluster/${local.name_prefix}-${var.cluster_name}" = "owned"

      "karpenter.sh/discovery" = "${local.name_prefix}-${var.cluster_name}"
    }
  )

}





###############################################
# Cluster to Nodes
###############################################

resource "aws_security_group_rule" "cluster_to_node_https" {

  type = "egress"

  from_port = 443

  to_port = 443

  protocol = "tcp"

  security_group_id = aws_security_group.cluster.id

  source_security_group_id = aws_security_group.node.id

}






###############################################
# Nodes to Cluster
###############################################

resource "aws_security_group_rule" "node_to_cluster_https" {

  type = "ingress"

  from_port = 443

  to_port = 443

  protocol = "tcp"

  security_group_id = aws_security_group.cluster.id

  source_security_group_id = aws_security_group.node.id

}





###############################################
# Node to Node
###############################################

resource "aws_security_group_rule" "node_to_node" {

  type = "ingress"

  from_port = 0

  to_port = 65535

  protocol = "-1"

  security_group_id = aws_security_group.node.id

  self = true

}



###############################################
# Node Egress
###############################################

resource "aws_security_group_rule" "node_egress" {

  type = "egress"

  from_port = 0

  to_port = 0

  protocol = "-1"

  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.node.id

}




###############################################
# Cluster Egress
###############################################

resource "aws_security_group_rule" "cluster_egress" {

  type = "egress"

  from_port = 0

  to_port = 0

  protocol = "-1"

  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.cluster.id

}







