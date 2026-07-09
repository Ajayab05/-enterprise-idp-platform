###############################################
# General Configuration
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

variable "enable_versioning" {
  type    = bool
  default = true
}

variable "force_destroy" {
  type    = bool
  default = false
}

###############################################
# Tags
###############################################

variable "tags" {
  type    = map(string)
  default = {}
}
