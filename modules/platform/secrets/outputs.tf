###############################################
# Secret ARNs
###############################################

output "secret_arns" {

  value = {

    for k, secret in aws_secretsmanager_secret.this :

    k => secret.arn

  }

}

###############################################
# IAM Policy
###############################################

output "secrets_policy_arn" {

  value = aws_iam_policy.secrets_access.arn

}
