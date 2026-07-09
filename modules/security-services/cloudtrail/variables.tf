###############################################
# General
###############################################

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "repository_name" {
  type = string
}

variable "owner" {
  type = string
}

###############################################
# Audit Module Outputs
###############################################

variable "audit_bucket_name" {
  type = string
}

variable "audit_kms_key_arn" {
  type = string
}

###############################################
# CloudTrail
###############################################

variable "trail_name" {
  type    = string
  default = "enterprise-trail"
}

variable "is_multi_region_trail" {
  type    = bool
  default = true
}

variable "include_global_service_events" {
  type    = bool
  default = true
}

variable "enable_log_file_validation" {
  type    = bool
  default = true
}

###############################################
# Tags
###############################################

variable "tags" {
  type    = map(string)
  default = {}
}
