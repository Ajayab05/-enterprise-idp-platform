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
# ECR
###############################################

variable "repositories" {

  description = "ECR repositories"

  type = list(string)

}

variable "image_tag_mutability" {

  type = string

  default = "IMMUTABLE"

}

variable "force_delete" {

  type = bool

  default = true

}

###############################################
# Tags
###############################################

variable "tags" {

  type = map(string)

  default = {}

}
