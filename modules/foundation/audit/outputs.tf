###############################################
# Bucket
###############################################

output "audit_bucket_name" {

  description = "Audit bucket"

  value = aws_s3_bucket.audit.id

}

output "audit_bucket_arn" {

  description = "Audit bucket ARN"

  value = aws_s3_bucket.audit.arn

}

###############################################
# KMS
###############################################

output "audit_kms_key_arn" {

  description = "Audit KMS Key"

  value = aws_kms_key.audit.arn

}

output "audit_kms_alias" {

  description = "Audit Alias"

  value = aws_kms_alias.audit.name

}
