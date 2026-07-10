###############################################
# AWS
###############################################

provider "aws" {
  region = var.aws_region
}

###############################################
# EKS Auth
###############################################

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

###############################################
# Kubernetes
###############################################

provider "kubernetes" {

  host = module.eks.cluster_endpoint

  cluster_ca_certificate = base64decode(
    module.eks.cluster_ca_certificate
  )

  token = data.aws_eks_cluster_auth.this.token

}

###############################################
# Helm
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
