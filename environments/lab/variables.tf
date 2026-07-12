###############################################
# General
###############################################

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

###############################################
# Networking
###############################################

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDRs"
  type        = list(string)
}

variable "private_app_subnet_cidrs" {
  description = "Private App Subnet CIDRs"
  type        = list(string)
}

variable "private_db_subnet_cidrs" {
  description = "Private DB Subnet CIDRs"
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "Use Single NAT Gateway"
  type        = bool
  default     = true
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
  type        = list(string)
}

###############################################
# Secrets Manager
###############################################

variable "secrets" {
  description = "Secrets Manager Secrets"
  type        = map(any)
}
