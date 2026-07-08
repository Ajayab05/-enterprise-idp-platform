###############################################
# General Configuration
###############################################

variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "aws_region" {
  description = "AWS region."
  type        = string
}

variable "repository_name" {
  description = "Repository name."
  type        = string
}

variable "owner" {
  description = "Platform owner."
  type        = string
}

###############################################
# VPC Configuration
###############################################

variable "vpc_cidr" {
  description = "VPC CIDR block."
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones."
  type        = list(string)
}

###############################################
# Public Subnets
###############################################

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs."
  type        = list(string)
}

###############################################
# Private Application Subnets
###############################################

variable "private_app_subnet_cidrs" {
  description = "Private application subnet CIDRs."
  type        = list(string)
}

###############################################
# Private Database Subnets
###############################################

variable "private_db_subnet_cidrs" {
  description = "Private database subnet CIDRs."
  type        = list(string)
}

###############################################
# NAT Gateway
###############################################

variable "single_nat_gateway" {
  description = "Deploy a single NAT Gateway."
  type        = bool
  default     = true
}

###############################################
# Resource Tags
###############################################

variable "tags" {
  description = "Additional resource tags."
  type        = map(string)
  default     = {}
}
