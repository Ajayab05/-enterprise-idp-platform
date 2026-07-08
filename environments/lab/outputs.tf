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
