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
  # Common Naming Prefix
  ###############################################

  name_prefix = "${local.project_name}-${local.environment}"

  ###############################################
  # Resource Names
  ###############################################

  vpc_name = "${local.name_prefix}-vpc"

  internet_gateway_name = "${local.name_prefix}-igw"

  nat_gateway_name = "${local.name_prefix}-nat"

  ###############################################
  # Common Tags
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
