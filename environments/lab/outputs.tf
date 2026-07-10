output "terraform_state_bucket" {

  value = module.terraform_backend.terraform_state_bucket

}

output "terraform_lock_table" {

  value = module.terraform_backend.terraform_lock_table

}

output "kms_key_arn" {

  value = module.terraform_backend.kms_key_arn

}


output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.networking.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.networking.private_db_subnet_ids
}



###############################################
# GitHub OIDC
###############################################

output "github_oidc_provider_arn" {
  description = "GitHub OIDC Provider ARN"
  value       = module.github_oidc.github_oidc_provider_arn
}

output "github_actions_role_arn" {
  description = "GitHub Actions IAM Role ARN"
  value       = module.github_oidc.github_actions_role_arn
}

output "terraform_policy_arn" {
  description = "Terraform IAM Policy ARN"
  value       = module.github_oidc.terraform_policy_arn
}




###############################################
# ECR
###############################################

output "ecr_repository_urls" {

  description = "ECR Repository URLs"

  value = module.ecr.repository_urls

}

output "ecr_repository_names" {

  description = "ECR Repository Names"

  value = module.ecr.repository_names

}




output "secret_arns" {

  value = module.secrets.secret_arns

}

output "secrets_policy_arn" {

  value = module.secrets.secrets_policy_arn

}





###############################################
# Audit
###############################################

output "audit_bucket_name" {
  value = module.audit.audit_bucket_name
}

output "audit_bucket_arn" {
  value = module.audit.audit_bucket_arn
}

output "audit_kms_key_arn" {
  value = module.audit.audit_kms_key_arn
}








###############################################
# Config
###############################################

output "config_recorder_name" {

  value = module.config.config_recorder_name

}

output "config_role_arn" {

  value = module.config.config_role_arn

}




###############################################
# GuardDuty
###############################################

output "guardduty_detector_id" {
  value = module.guardduty.guardduty_detector_id
}




###############################################
# Security Hub
###############################################

output "securityhub_enabled" {
  value = module.securityhub.securityhub_enabled
}




###############################################
# Inspector
###############################################

output "enabled_resource_types" {

  value = module.inspector.enabled_resource_types

}





output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "eks_cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}

output "oidc_provider_arn" {
  value = module.oidc.oidc_provider_arn
}
###############################################
# OIDC Provider ARN
######################################}
