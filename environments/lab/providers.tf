###############################################
# AWS Provider
###############################################

provider "aws" {
  region = var.aws_region
}

###############################################
# EKS Authentication
###############################################

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

###############################################
# Kubernetes Provider
###############################################

provider "kubernetes" {

  host = module.eks.cluster_endpoint

  cluster_ca_certificate = base64decode(
    module.eks.cluster_ca_certificate
  )

  token = data.aws_eks_cluster_auth.this.token

}

###############################################
# Helm Provider
###############################################

provider "helm" {

  kubernetes = {

    host = module.eks.cluster_endpoint

    cluster_ca_certificate = base64decode(
      module.eks.cluster_ca_certificate
    )

    token = data.aws_eks_cluster_auth.this.token

  }

}
