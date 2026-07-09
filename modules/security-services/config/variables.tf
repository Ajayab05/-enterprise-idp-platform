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
# Audit
###############################################

variable "audit_bucket_name" {
  type = string
}

###############################################
# Config
###############################################

variable "recorder_name" {
  type    = string
  default = "enterprise-config-recorder"
}

variable "delivery_channel_name" {
  type    = string
  default = "enterprise-config-delivery"
}

variable "tags" {
  type    = map(string)
  default = {}
}
