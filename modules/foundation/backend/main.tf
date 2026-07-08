###############################################
# KMS Key for Terraform Backend
###############################################

resource "aws_kms_key" "terraform_backend" {

  description             = "KMS key for Terraform remote state encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = var.enable_key_rotation

  tags = merge(
    local.common_tags,
    {
      Name = local.kms_key_name
    }
  )
}

###############################################
# KMS Alias
###############################################

resource "aws_kms_alias" "terraform_backend" {

  name          = local.kms_alias_name
  target_key_id = aws_kms_key.terraform_backend.key_id
}




###############################################
# Terraform State S3 Bucket
###############################################

resource "aws_s3_bucket" "terraform_state" {

  bucket        = local.s3_bucket_name
  force_destroy = var.force_destroy

  tags = merge(
    local.common_tags,
    {
      Name = local.s3_bucket_name
    }
  )
}


###############################################
# S3 Bucket Versioning
###############################################

resource "aws_s3_bucket_versioning" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = var.enable_bucket_versioning ? "Enabled" : "Suspended"
  }
}



###############################################
# S3 Bucket Encryption
###############################################

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  rule {

    apply_server_side_encryption_by_default {

      kms_master_key_id = aws_kms_key.terraform_backend.arn

      sse_algorithm = "aws:kms"

    }

    bucket_key_enabled = true
  }
}



###############################################
# Block Public Access
###############################################

resource "aws_s3_bucket_public_access_block" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}




###############################################
# Bucket Ownership Controls
###############################################

resource "aws_s3_bucket_ownership_controls" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  rule {

    object_ownership = "BucketOwnerEnforced"

  }
}



###############################################
# DynamoDB Table for Terraform State Locking
###############################################

resource "aws_dynamodb_table" "terraform_lock" {

  name         = local.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  deletion_protection_enabled = true

  tags = merge(
    local.common_tags,
    {
      Name = local.dynamodb_table_name
    }
  )
}
