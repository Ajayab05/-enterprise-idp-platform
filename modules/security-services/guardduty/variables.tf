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
# GuardDuty
###############################################

variable "enable_guardduty" {
  type    = bool
  default = true
}

variable "finding_publishing_frequency" {
  type    = string
  default = "FIFTEEN_MINUTES"
}

###############################################
# Tags
###############################################

variable "tags" {
  type    = map(string)
  default = {}
}
