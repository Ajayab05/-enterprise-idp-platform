data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

###############################################
# AWS Config Assume Role Policy
###############################################

data "aws_iam_policy_document" "config_assume_role" {

  statement {

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "config.amazonaws.com"
      ]

    }

    actions = [
      "sts:AssumeRole"
    ]

  }

}
