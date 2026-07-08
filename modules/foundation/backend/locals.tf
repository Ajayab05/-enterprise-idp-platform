###############################################
# Local Values
###############################################

locals {

  ###############################################
  # Normalized Values
  ###############################################

  project_name = lower(trim(var.project_name, " "))
  environment  = lower(trim(var.environment, " "))
  aws_region   = lower(trim(var.aws_region, " "))

  ###############################################
  # Common Resource Prefix
  ###############################################

  name_prefix = "${local.project_name}-${local.environment}"

  ###############################################
  # Resource Names
  ###############################################

  kms_key_name   = "${local.name_prefix}-terraform-kms"
  kms_alias_name = "alias/${local.name_prefix}-terraform"

  s3_bucket_name = format(
    "%s-tfstate-%s",
    local.name_prefix,
    data.aws_caller_identity.current.account_id
  )

  dynamodb_table_name = "${local.name_prefix}-tf-lock"

  ###############################################
  # Standard Tags
  ###############################################

  mandatory_tags = {
    Project         = local.project_name
    Environment     = local.environment
    Region          = local.aws_region
    ManagedBy       = "Terraform"
    Repository      = var.repository_name
    Owner           = var.owner
    Terraform       = "true"
    Confidentiality = "Internal"
  }

  common_tags = merge(
    local.mandatory_tags,
    var.tags
  )

}
