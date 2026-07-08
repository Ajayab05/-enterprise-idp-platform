###############################################
# Backend Outputs
###############################################

output "kms_key_arn" {
  description = "Terraform backend KMS key ARN"

  value = aws_kms_key.terraform_backend.arn
}

output "kms_key_id" {
  description = "Terraform backend KMS key ID"

  value = aws_kms_key.terraform_backend.key_id
}

output "kms_alias" {
  description = "Terraform backend KMS alias"

  value = aws_kms_alias.terraform_backend.name
}

output "terraform_state_bucket" {
  description = "Terraform state S3 bucket"

  value = aws_s3_bucket.terraform_state.bucket
}

output "terraform_lock_table" {
  description = "Terraform DynamoDB lock table"

  value = aws_dynamodb_table.terraform_lock.name
}
