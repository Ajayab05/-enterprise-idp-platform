###############################################
# Audit KMS Key
###############################################

resource "aws_kms_key" "audit" {

  description             = "KMS Key for Audit Services"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  policy = data.aws_iam_policy_document.audit_kms.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-audit-kms"
    }
  )
}

###############################################
# Audit KMS Alias
###############################################

resource "aws_kms_alias" "audit" {

  name = "alias/${local.name_prefix}-audit"

  target_key_id = aws_kms_key.audit.key_id

}

###############################################
# Audit S3 Bucket
###############################################

resource "aws_s3_bucket" "audit" {

  bucket = "${local.name_prefix}-audit-${data.aws_caller_identity.current.account_id}"

  force_destroy = var.force_destroy

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-audit"
    }
  )

}

###############################################
# Bucket Versioning
###############################################

resource "aws_s3_bucket_versioning" "audit" {

  bucket = aws_s3_bucket.audit.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }

}

###############################################
# Server Side Encryption
###############################################

resource "aws_s3_bucket_server_side_encryption_configuration" "audit" {

  bucket = aws_s3_bucket.audit.id

  rule {

    apply_server_side_encryption_by_default {

      kms_master_key_id = aws_kms_key.audit.arn

      sse_algorithm = "aws:kms"

    }

    bucket_key_enabled = true

  }

}

###############################################
# Public Access Block
###############################################

resource "aws_s3_bucket_public_access_block" "audit" {

  bucket = aws_s3_bucket.audit.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

###############################################
# Ownership Controls
###############################################

resource "aws_s3_bucket_ownership_controls" "audit" {

  bucket = aws_s3_bucket.audit.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }

}

###############################################
# Lifecycle Configuration
###############################################

resource "aws_s3_bucket_lifecycle_configuration" "audit" {

  bucket = aws_s3_bucket.audit.id

  rule {

    id     = "audit-retention"
    status = "Enabled"

    filter {}

    transition {

      days          = 90
      storage_class = "STANDARD_IA"

    }

    transition {

      days          = 180
      storage_class = "GLACIER"

    }

    expiration {

      days = 2555

    }

  }

}

###############################################
# Bucket Policy
###############################################

resource "aws_s3_bucket_policy" "audit" {

  bucket = aws_s3_bucket.audit.id

  policy = data.aws_iam_policy_document.audit_bucket.json

}
