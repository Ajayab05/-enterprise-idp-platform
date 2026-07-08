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
# Networking
###############################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

###############################################
# Resource Tags
###############################################

variable "tags" {
  type    = map(string)
  default = {}
}
