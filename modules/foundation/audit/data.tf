###############################################
# AWS Account Information
###############################################

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

###############################################
# Audit KMS Key Policy
###############################################

data "aws_iam_policy_document" "audit_kms" {

  statement {

    sid    = "EnableRootPermissions"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = [
      "kms:*"
    ]

    resources = [
      "*"
    ]
  }

  statement {

    sid    = "AllowCloudTrail"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }

    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt",
      "kms:DescribeKey"
    ]

    resources = [
      "*"
    ]
  }

  statement {

    sid    = "AllowAWSConfig"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "config.amazonaws.com"
      ]
    }

    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt",
      "kms:DescribeKey"
    ]

    resources = [
      "*"
    ]
  }

}

###############################################
# Audit Bucket Policy
###############################################

data "aws_iam_policy_document" "audit_bucket" {

  #################################################
  # Deny Insecure Transport
  #################################################

  statement {

    sid    = "DenyInsecureTransport"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.audit.arn,
      "${aws_s3_bucket.audit.arn}/*"
    ]

    condition {

      test     = "Bool"
      variable = "aws:SecureTransport"

      values = [
        "false"
      ]
    }

  }

  #################################################
  # CloudTrail ACL Check
  #################################################

  statement {

    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }

    actions = [
      "s3:GetBucketAcl"
    ]

    resources = [
      aws_s3_bucket.audit.arn
    ]

  }

  #################################################
  # CloudTrail Write
  #################################################

  statement {

    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.audit.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    condition {

      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control"
      ]
    }

  }

  #################################################
  # AWS Config (Future)
  #################################################

  statement {

    sid    = "AWSConfigBucketPermissionsCheck"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "config.amazonaws.com"
      ]
    }

    actions = [
      "s3:GetBucketAcl",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.audit.arn
    ]

  }

  statement {

    sid    = "AWSConfigBucketDelivery"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "config.amazonaws.com"
      ]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.audit.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/Config/*"
    ]

    condition {

      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control"
      ]
    }

  }

}
