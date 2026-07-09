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
# Secrets
###############################################

variable "secrets" {

  description = "Secrets to create"

  type = map(any)

}

###############################################
# Tags
###############################################

variable "tags" {

  type = map(string)

  default = {}

}
