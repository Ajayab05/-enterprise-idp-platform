###############################################
# AWS
###############################################

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

###############################################
# EKS Cluster
###############################################

data "aws_eks_cluster" "this" {

  name = var.cluster_name

}

###############################################
# OIDC Certificate
###############################################

data "tls_certificate" "oidc" {

  url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer

}
