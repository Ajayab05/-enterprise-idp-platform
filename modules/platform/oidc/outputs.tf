###############################################
# OIDC Provider ARN
###############################################

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}

###############################################
# OIDC Provider URL
###############################################

output "oidc_provider_url" {
  value = aws_iam_openid_connect_provider.eks.url
}
