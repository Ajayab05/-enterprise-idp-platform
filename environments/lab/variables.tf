variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "repository_name" {
  description = "Repository Name"
  type        = string
}

variable "owner" {
  description = "Platform Owner"
  type        = string
}

variable "tags" {
  description = "Additional Tags"
  type        = map(string)
  default     = {}
}


variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_app_subnet_cidrs" {
  type = list(string)
}

variable "private_db_subnet_cidrs" {
  type = list(string)
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}




###############################################
# GitHub OIDC
###############################################

variable "github_organization" {
  description = "GitHub organization or username"
  type        = string
}

variable "github_repositories" {
  description = "GitHub repositories"
  type        = list(string)
}

variable "github_branch" {
  description = "GitHub branch"
  type        = string
  default     = "main"
}






###############################################
# ECR
###############################################

variable "repositories" {

  description = "Application repositories"

  type = list(string)

}




variable "secrets" {

  type = map(any)

}






