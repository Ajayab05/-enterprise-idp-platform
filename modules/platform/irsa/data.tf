data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "this" {

  name = var.cluster_name

}
