###############################################
# KMS
###############################################

output "eks_kms_key_arn" {

  value = aws_kms_key.eks.arn

}

output "eks_kms_alias" {

  value = aws_kms_alias.eks.name

}
###############################################
# Cluster
###############################################

output "cluster_name" {

  value = aws_eks_cluster.this.name

}

output "cluster_arn" {

  value = aws_eks_cluster.this.arn

}

output "cluster_endpoint" {

  value = aws_eks_cluster.this.endpoint

}

output "cluster_version" {

  value = aws_eks_cluster.this.version

}

output "cluster_security_group_id" {

  value = aws_security_group.cluster.id

}

output "cluster_role_arn" {

  value = aws_iam_role.cluster.arn

}

#

###############################################
# Worker Nodes
###############################################

output "node_role_arn" {

  value = aws_iam_role.node.arn

}

output "node_instance_profile" {

  value = aws_iam_instance_profile.node.name

}



##############################################




###############################################
# Launch Template
###############################################

###############################################
# System Node Group
###############################################

output "system_nodegroup_name" {

  value = aws_eks_node_group.system.node_group_name

}

output "system_nodegroup_arn" {

  value = aws_eks_node_group.system.arn

}





###############################################
# Cluster CA Certificate
###############################################

output "cluster_ca_certificate" {

  description = "EKS Cluster CA Certificate"

  value = aws_eks_cluster.this.certificate_authority[0].data

}
