output "securityhub_enabled" {
  value = aws_securityhub_account.this.id
}

output "finding_aggregator_arn" {
  value = aws_securityhub_finding_aggregator.this.arn
}
