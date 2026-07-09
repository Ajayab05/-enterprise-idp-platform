###############################################
# AWS Security Hub
###############################################

resource "aws_securityhub_account" "this" {

  enable_default_standards = var.enable_default_standards

}

###############################################
# Security Hub Finding Aggregator
###############################################

resource "aws_securityhub_finding_aggregator" "this" {

  linking_mode = "ALL_REGIONS"

  depends_on = [
    aws_securityhub_account.this
  ]

}
