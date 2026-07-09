###############################################
# CloudTrail
###############################################

resource "aws_cloudtrail" "this" {

  name = "${local.name_prefix}-${var.trail_name}"

  s3_bucket_name = var.audit_bucket_name

  kms_key_id = var.audit_kms_key_arn

  include_global_service_events = var.include_global_service_events

  is_multi_region_trail = var.is_multi_region_trail

  enable_log_file_validation = var.enable_log_file_validation

  enable_logging = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-cloudtrail"
    }
  )

}
