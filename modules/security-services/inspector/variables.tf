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
# Inspector
###############################################

variable "enable_ec2" {
  type    = bool
  default = true
}

variable "enable_ecr" {
  type    = bool
  default = true
}

variable "enable_lambda" {
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
