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
  description = "GitHub repository"
  type        = string
}

variable "owner" {
  description = "Platform owner"
  type        = string
}

###############################################
# GitHub
###############################################

variable "github_organization" {
  description = "GitHub Organization or User"
  type        = string
}

variable "github_repositories" {
  description = "GitHub repositories allowed to use this OIDC provider"
  type        = list(string)
}

variable "github_branch" {
  description = "Allowed branch"
  type        = string

  default = "main"
}

###############################################
# Tags
###############################################

variable "tags" {
  type    = map(string)
  default = {}
}
