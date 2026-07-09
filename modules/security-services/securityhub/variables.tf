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
# Security Hub
###############################################

variable "enable_default_standards" {
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
