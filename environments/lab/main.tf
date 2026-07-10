module "terraform_backend" {

  source = "../../modules/foundation/backend"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  tags = var.tags

}



module "networking" {

  source = "../../modules/foundation/networking"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnet_cidrs = var.public_subnet_cidrs

  private_app_subnet_cidrs = var.private_app_subnet_cidrs

  private_db_subnet_cidrs = var.private_db_subnet_cidrs

  single_nat_gateway = var.single_nat_gateway

  tags = var.tags
}




module "security" {

  source = "../../modules/foundation/security"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  vpc_id = module.networking.vpc_id

  tags = var.tags
}








module "github_oidc" {

  source = "../../modules/platform/github-oidc"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  github_organization = var.github_organization
  github_repositories = var.github_repositories
  github_branch       = var.github_branch

  tags = var.tags
}


###############################################
# ECR
###############################################

module "ecr" {

  source = "../../modules/platform/ecr"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  repositories = var.repositories

  tags = var.tags

}



module "secrets" {

  source = "../../modules/platform/secrets"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  secrets = var.secrets

  tags = var.tags

}




###############################################
# Audit Foundation
###############################################

module "audit" {

  source = "../../modules/foundation/audit"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  force_destroy = false

  tags = var.tags

}



module "cloudtrail" {

  source = "../../modules/security-services/cloudtrail"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  audit_bucket_name = module.audit.audit_bucket_name
  audit_kms_key_arn = module.audit.audit_kms_key_arn

  tags = var.tags

}




###############################################
# AWS Config
###############################################

module "config" {

  source = "../../modules/security-services/config"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  audit_bucket_name = module.audit.audit_bucket_name

  tags = var.tags

}





###############################################
# GuardDuty
###############################################

module "guardduty" {

  source = "../../modules/security-services/guardduty"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  tags = var.tags

}




###############################################
# Security Hub
###############################################

module "securityhub" {

  source = "../../modules/security-services/securityhub"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  tags = var.tags

}



###############################################
# Amazon Inspector
###############################################

module "inspector" {

  source = "../../modules/security-services/inspector"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  tags = var.tags

}


###############################################
# Enterprise EKS
###############################################

module "eks" {

  source = "../../modules/platform/eks"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  vpc_id = module.networking.vpc_id

  private_subnet_ids = module.networking.private_app_subnet_ids

  tags = var.tags

}







###############################################
# EKS IRSA Foundation
###############################################

module "oidc" {

  source = "../../modules/platform/oidc"

  cluster_name = module.eks.cluster_name

  project_name = var.project_name

  environment = var.environment

  tags = var.tags

  depends_on = [
    module.eks
  ]

}


module "ebs_csi" {

  source       = "../../modules/platform/addons/ebs-csi"
  cluster_name = module.eks.cluster_name

  project_name = var.project_name

  environment = var.environment

  tags = var.tags

  depends_on = [
    module.eks
  ]

}





###############################################
# Metrics Server
###############################################

module "metrics_server" {

  source = "../../modules/platform/addons/metrics-server"

  tags = var.tags

  depends_on = [
    module.eks
  ]

}




module "aws_load_balancer_controller" {

  source = "../../modules/platform/addons/aws-load-balancer-controller"

  cluster_name = module.eks.cluster_name

  project_name = var.project_name

  environment = var.environment

  tags = var.tags

  depends_on = [
    module.eks
  ]
}



###############################################
# Route53
###############################################

module "route53" {

  source = "../../modules/platform/route53"

  domain_name = "ajay.bar"

  project_name = var.project_name

  environment = var.environment

  tags = var.tags

}



module "external_dns" {

  source = "../../modules/platform/addons/external-dns"

  cluster_name   = module.eks.cluster_name
  hosted_zone_id = module.route53.hosted_zone_id
  domain_name    = "ajay.bar"

  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags

  depends_on = [
    module.route53,
    module.aws_load_balancer_controller
  ]
}







###############################################
# ACM Certificate
###############################################

module "certificates" {

  source = "../../modules/platform/certificates"

  domain_name = "app.ajay.bar"

  hosted_zone_id = module.route53.hosted_zone_id

  project_name = var.project_name

  environment = var.environment

  tags = var.tags

  depends_on = [

    module.route53

  ]

}










###############################################
# ArgoCD
###############################################

module "argocd" {

  source = "../../modules/platform/addons/argocd"

  cluster_name = module.eks.cluster_name

  project_name = var.project_name

  environment = var.environment

  tags = var.tags

  depends_on = [
    module.aws_load_balancer_controller
  ]

}



